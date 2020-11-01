import UIKit


extension UITableView {
    
    func setPlaceholder(ofKind: PlaceholderKind) {
        let placeholderView = PlaceholderView()
        let placeholderFactory = PlaceholderFactory(placeholderView)
        let viewModel = placeholderFactory.createModel(ofKind: ofKind)
        let placeholder = placeholderFactory.createPlaceholder(model: viewModel)
        
        self.backgroundView = placeholder
        placeholderView.delegate = self
        self.separatorStyle = .none
        if let animationFunction = viewModel.animationFunction {
            animationFunction(placeholder.placeholderImageView)
        }
    }
    
    func restoreTableView(separatorStyle: UITableViewCell.SeparatorStyle) {
        self.backgroundView = nil
        self.separatorStyle = separatorStyle
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
