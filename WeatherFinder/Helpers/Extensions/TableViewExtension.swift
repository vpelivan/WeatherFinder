import UIKit


extension UITableView {
    
    func setPlaceholder(ofKind: PlaceholderKind) {
        
        let placeholderView = PlaceholderView()

        self.backgroundView = placeholderView
        placeholderView.delegate = self
        setupPlaceholderKind(kind: ofKind, view: placeholderView)
        self.separatorStyle = .none
    }
    
    func restoreTableView(separatorStyle: UITableViewCell.SeparatorStyle) {
        self.backgroundView = nil
        self.separatorStyle = separatorStyle
    }
    
    private func setupPlaceholderKind(kind: PlaceholderKind, view: PlaceholderView) {
        switch kind {
        case .loadingData:
            let image = UIImage(named: "SunSpinner")
            view.descriptionLabel.isHidden = true
            view.updatePlaceholderViewData(PlaceholderTitle.loadingData.rawValue,
                                           PlaceholderKind.loadingData.rawValue,
                                           nil,
                                           image)
        case .noResults:
            let image = UIImage(named: "RainbowNoResults")
            view.updatePlaceholderViewData(PlaceholderTitle.noResults.rawValue,
                                           PlaceholderKind.noResults.rawValue,
                                           nil,
                                           image)
        case .noInternet:
            let image = UIImage(named: "CloudNoInternet")
            view.updatePlaceholderViewData(PlaceholderTitle.noInternet.rawValue,
                                           PlaceholderKind.noInternet.rawValue,
                                           nil,
                                           image)
        case .geolocationOff:
            let image = UIImage(named: "LightningNoGeolocation")
            view.updatePlaceholderViewData(PlaceholderTitle.geolocationOff.rawValue,
                                           PlaceholderKind.geolocationOff.rawValue,
                                           nil,
                                           image)
        case .geolocationRestricted:
            let image = UIImage(named: "LightningNoGeolocation")
            view.goToSettingsButton.isHidden = false
            view.updatePlaceholderViewData(PlaceholderTitle.geolocationRestricted.rawValue,
                                           PlaceholderKind.geolocationRestricted.rawValue,
                                           PlaceholderButton.geolocationRestricted.rawValue,
                                           image)
        }
    }
}

extension UITableView: PlaceholderViewDelegate {
    
    func onButtonTapped() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
