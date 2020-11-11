import UIKit

extension UITableView {

    func setPlaceholder(kind: Placeholder) {
        let placeholderView = PlaceholderView()
        let placeholderFactory = PlaceholderFactory(placeholderView)
        let configuredPlaceholder = placeholderFactory.getConfiguredPlaceholder(from: kind)
        backgroundView = configuredPlaceholder
        placeholderView.delegate = self
        separatorStyle = .none
        performAnimation(viewModel: kind, placeholder: configuredPlaceholder)
    }

    func restoreTableView(separatorStyle: UITableViewCell.SeparatorStyle) {
        backgroundView = nil
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

extension UITableView {
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else { fatalError("Could not deque cell with type \(T.self)")
        }
        return cell
    }
}
