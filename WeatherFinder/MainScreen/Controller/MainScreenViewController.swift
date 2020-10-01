
import UIKit

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var searchController: UISearchController?
    
    let colors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        refresh()
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
        let backgroundLayer = colors.gradientLayer!
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }

    @IBAction func updateLocation(_ sender: UIBarButtonItem) {
    }
}

