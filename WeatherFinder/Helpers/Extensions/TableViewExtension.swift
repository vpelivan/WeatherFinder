import UIKit

enum PlaceholderKind {
    case noResults
    case noInternet
    case loadingData
    case noGeolocation
}

extension UITableView {
    
    func setPlaceholder(ofKind: PlaceholderKind, image: UIImage? = nil, title: String? = nil, message: String? = nil, button: UIButton? = nil) {
        
//        switch ofKind {
//        case .loadingData:
//        case .noResults:
//        case .noInternet:
//        }
        
        let emptyViewFrame = CGRect(x: self.center.x,
                                    y: self.center.y,
                                    width: self.bounds.size.width,
                                    height: self.bounds.size.height)
        
        let emptyView = PlaceholderView(frame: emptyViewFrame)

//        titleLabel.transform = CGAffineTransform(translationX: 500, y: 0)
//        UIView.animate(withDuration: 1.0, delay: 1.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
//            titleLabel.transform = .identity
//        })
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
