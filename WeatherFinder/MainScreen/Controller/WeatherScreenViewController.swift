
import UIKit

class WeatherScreenViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // TODO: resolve variable searchController initialization issue
    private var searchController: UISearchController?
    
    private let gradientLayer = Colors.gradientLayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        refresh()
    }
    
    override public func traitCollectionDidChange(_ previouseTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previouseTraitCollection)
        
        gradientLayer.frame = view.bounds
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController?.searchBar.placeholder = "Search for city".localized
    }
    
    private func refresh() {
        view.backgroundColor = .clear
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction private func updateLocation(_ sender: UIBarButtonItem) {
    }
}
