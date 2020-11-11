import Foundation
import CoreLocation

protocol GeolocationDelegate: class {
    func authorizationStatusSetup(state: CurrentAutorizationStatus)
    func locationRecieved(location: CLLocation?)
}

enum CurrentAutorizationStatus {
    case geolocationDenied
    case geolocationOff
    case geolocationAllowed
}

class Geolocation: NSObject {
    weak var delegate: GeolocationDelegate?
    let locationManager = CLLocationManager()
    var location: CLLocation? = nil {
        didSet {
            delegate?.locationRecieved(location: location)
        }
    }

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func checkAuthorizationStatus() {
        guard CLLocationManager.locationServicesEnabled() else {
            delegate?.authorizationStatusSetup(state: .geolocationOff)
            return
        }

        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            delegate?.authorizationStatusSetup(state: .geolocationDenied)
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            delegate?.authorizationStatusSetup(state: .geolocationAllowed)
            startLocationManager()
        default:
            break
        }
    }

    private func startLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - Extension
extension Geolocation: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
            // после реализации сетевого слоя эти строчки с выводом координат в консоль будут удалены
            print("Longitude: \(location.coordinate.longitude), Latitude: \(location.coordinate.latitude)")
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
