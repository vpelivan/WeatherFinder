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
        let animations = Animations()
        
        switch kind {
        case .loadingData:
            let image = UIImage(named: "SunSpinner")
            view.descriptionLabel.isHidden = true
            view.updatePlaceholderViewData(PlaceholderTitle.loadingData.rawValue,
                                           PlaceholderKind.loadingData.rawValue,
                                           nil,
                                           image)
            animations.startRotateAnimation(imageView: view.placeholderImageView)
        case .noResults:
            let image = UIImage(named: "RainbowNoResults")
            view.updatePlaceholderViewData(PlaceholderTitle.noResults.rawValue,
                                           PlaceholderKind.noResults.rawValue,
                                           nil,
                                           image)
            animations.startUnfadeAnimation(imageView: view.placeholderImageView)
            
        case .noInternet:
            let image = UIImage(named: "CloudNoInternet")
            view.updatePlaceholderViewData(PlaceholderTitle.noInternet.rawValue,
                                           PlaceholderKind.noInternet.rawValue,
                                           nil,
                                           image)
            animations.startBouncingAnimation(imageView: view.placeholderImageView)
        case .geolocationOff:
            let image = UIImage(named: "LightningNoGeolocation")
            view.updatePlaceholderViewData(PlaceholderTitle.geolocationOff.rawValue,
                                           PlaceholderKind.geolocationOff.rawValue,
                                           nil,
                                           image)
            animations.startBouncingAnimation(imageView: view.placeholderImageView)
        case .geolocationDenied:
            let image = UIImage(named: "LightningNoGeolocation")
            view.goToSettingsButton.isHidden = false
            view.updatePlaceholderViewData(PlaceholderTitle.geolocationDenied.rawValue,
                                           PlaceholderKind.geolocationDenied.rawValue,
                                           PlaceholderButton.geolocationDenied.rawValue,
                                           image)
            animations.startBouncingAnimation(imageView: view.placeholderImageView)
        }
    }
}

extension UITableView: PlaceholderViewDelegate {
    
    func onButtonTapped() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url) { _ in
                    // after turning back from settings the following block should execute
                }
            }
        }
    }
}
