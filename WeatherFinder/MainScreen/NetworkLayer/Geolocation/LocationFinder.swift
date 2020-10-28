
import Foundation
import CoreLocation

protocol GeolocationDelegate {
    func authorizationDidChange(granted: Bool)
    //TODO: - указать метод, который будет возвразщать нам структуру данных с координатами.
    //    func getCoordinates() -> vovinaStructura
    
    func locationServicesDisabled()
}
class Geolocation: NSObject {
    var delegate: GeolocationDelegate?
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func startLocationManager() {
        
        if CLLocationManager.locationServicesEnabled() == true {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        }else {
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
            delegate?.authorizationDidChange(granted: status != CLAuthorizationStatus.denied)
        }
    }
}
