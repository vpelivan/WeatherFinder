
import UIKit

struct Colors {
    var gradientLayer: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let colorTop = addRgbaColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        let colorBottom = addRgbaColor(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
}

extension Colors {
    func addRgbaColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> CGColor {
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        return color
    }
}
