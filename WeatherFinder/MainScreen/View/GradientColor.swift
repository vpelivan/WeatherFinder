
import UIKit

class Colors {
    var gradientLayer: CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0).cgColor
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.colors = [colorTop, colorBottom]
        self.gradientLayer.locations = [0.0, 1.0]
    }
}
