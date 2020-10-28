import UIKit

enum PlaceholderKind: String {
    case loadingData
    case noResults = "Unable to find city"
    case noInternet = "You can switch on internet by pressing Internet Settings button"
    case geolocationRestricted, geolocationOff = "You can switch on geolocation manually by pressing Geolocation Settings button"
}

enum PlaceholderButton: String {
    case noInternet = "Internet Settings"
    case geolocationRestricted, geolocationOff = "Geolocation Settings"
}

extension UITableView {
    
    func setPlaceholder(ofKind: PlaceholderKind,
                        title: String?,
                        description: String? = nil,
                        buttonLabelText: PlaceholderButton? = nil,
                        image: UIImage? = nil) {
        
        let placeholderViewFrame = CGRect(x: self.center.x,
                                          y: self.center.y,
                                          width: self.bounds.size.width,
                                          height: self.bounds.size.height)
        
        let placeholderView = PlaceholderView(frame: placeholderViewFrame)
        placeholderView.delegate = self
        placeholderView.setupPlaceholderKind(ofKind)
        placeholderView.updatePlaceholderViewData(title, ofKind.rawValue, buttonLabelText?.rawValue, image)
        self.backgroundView = placeholderView
        self.separatorStyle = .none
    }
    
    func restoreTableView(separatorStyle: UITableViewCell.SeparatorStyle) {
        self.backgroundView = nil
        self.separatorStyle = separatorStyle
    }
}

extension UITableView: PlaceholderViewDelegate {
    func onButtonTapped() {
        //TODO: Perform opening settings
        print("go to settings")
    }
}
