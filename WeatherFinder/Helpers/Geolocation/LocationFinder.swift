
import Foundation
import CoreLocation

protocol GeolocationDelegate {
//    func authorizationDidChange(granted: Bool)
    //TODO: - указать метод, который будет возвразщать нам структуру данных с координатами.
    //    func getCoordinates() -> vovinaStructura
    func switchOffPlaceholder()
    func locationServicesDisabled()
    func authorizationDenied()
    func authorizationAllowed()
}
class Geolocation: NSObject {
    var delegate: GeolocationDelegate?
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func startLocationManager() {
        
        switch locationManager.authorizationStatus {
        case .restricted:
            delegate?.locationServicesDisabled()
        case .denied:
//            delegate?.authorizationDidChange(granted: locationManager.authorizationStatus != CLAuthorizationStatus.denied)
            delegate?.authorizationDenied()
            return
        case .authorizedAlways:
            delegate?.switchOffPlaceholder()
        case .authorizedWhenInUse:
            delegate?.switchOffPlaceholder()
        default:
            break
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        } else {
            delegate?.locationServicesDisabled()
        }
    }
}

// MARK: - Extension
extension Geolocation: CLLocationManagerDelegate {
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            //TODO: -здесь будет вызываться метод делегата возвращающий структуру с координатами
            
            // после реализации сетевого слоя эти строчки с выводом координат в консоль будут удалены.
            print(lastLocation.coordinate.latitude)
            print(lastLocation.coordinate.longitude)
        }
        
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
//            delegate?.authorizationDidChange(granted: status != CLAuthorizationStatus.denied)
            delegate?.authorizationDenied()
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            delegate?.switchOffPlaceholder()
            delegate?.authorizationAllowed()
        }
    }
}
