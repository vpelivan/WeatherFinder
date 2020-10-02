
import UIKit

class WeatherScreenViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var searchController: UISearchController?
    
    private let colors = Colors()
    private let gradientLayer = Colors().gradientLayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        refresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.frame = view.bounds
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController?.searchBar.placeholder = "Search for city"
    }
    
    private func refresh() {
        view.backgroundColor = .clear
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction private func updateLocation(_ sender: UIBarButtonItem) {
    }
}

