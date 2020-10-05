
import UIKit

struct Colors {
    static var gradientLayer: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let colorTop = addRgbaColor(red: 0.0, green:0.0, blue: 250.0)
        let colorBottom = addRgbaColor(red: 135.0, green: 206.0, blue: 250.0)
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
}

extension Colors {
    static private func addRgbaColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> CGColor {
        let color = UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha).cgColor
        return color
    }
}
