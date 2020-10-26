
import Foundation
import CoreLocation

class Geolocation: NSObject {
    
    let locationManager = CLLocationManager()
    var geolocationDenied = false
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func startLocationManager() {
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() == true {
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            geolocationDenied = true
            //тут будет метод, который будет вызывать плэйсхолдер, если пользователь не разрешил доступ к данным геопозиции
        print("Placeholder")
        } 
    }
}
