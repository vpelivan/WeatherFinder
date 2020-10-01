
import UIKit

class MainScreenViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        
        
        
        
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController?.searchBar.placeholder = "Search for city"
    }
    
    @IBAction func updateLocation(_ sender: UIBarButtonItem) {
        
    }
    
    
    
}

