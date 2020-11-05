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
        performAnimation(viewModel: viewModel, placeholder: placeholder)
    }
    
    func restoreTableView(separatorStyle: UITableViewCell.SeparatorStyle) {
        self.backgroundView = nil
        self.separatorStyle = separatorStyle
    }
    
    private func performAnimation(viewModel: SettingsPlaceholderViewModel,
                                  placeholder: PlaceholderView) {
        if let animationFunction = viewModel.animationFunction {
            animationFunction(placeholder.placeholderImageView)
        }
    }
}

extension UITableView: PlaceholderViewDelegate {
    func placeholderButtonBeingTapped() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
