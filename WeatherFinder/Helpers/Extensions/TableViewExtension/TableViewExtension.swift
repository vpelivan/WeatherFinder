import UIKit

extension UITableView {

    func setPlaceholder(ofKind: PlaceholderKind) {
        let placeholderView = PlaceholderView()
        let placeholderFactory = PlaceholderFactory(placeholderView)
        let viewModel = placeholderFactory.createModel(ofKind: ofKind)
        let configuredPlaceholder = placeholderFactory.configurePlaceholder(with: viewModel)

        self.backgroundView = configuredPlaceholder
        placeholderView.delegate = self
        self.separatorStyle = .none
        performAnimation(viewModel: viewModel, placeholder: configuredPlaceholder)
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
