
import Foundation
import CoreLocation

class Geolocation: NSObject {
    
    let locationManager = CLLocationManager()
    
    func startLocationManager() {
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - Extension
extension Geolocation: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            // после реализации сетевого слоя эти строчки с выводом координат в консоль будут удалены.
            print(lastLocation.coordinate.latitude)
            print(lastLocation.coordinate.longitude)
        }
        locationManager.stopUpdatingLocation()
    }
}
