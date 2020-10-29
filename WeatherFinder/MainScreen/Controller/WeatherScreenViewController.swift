
import UIKit

class WeatherScreenViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // TODO: resolve variable searchController initialization issue
    private var searchController: UISearchController?
    
    private let gradientLayer = Colors.gradientLayer
    private let geolocation = Geolocation()
    private var locationDenied = false{
        willSet{
            if newValue == true {
                print("set placeholder")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        refresh()
        setupGeolocation()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        gradientLayer.frame = CGRect(origin: gradientLayer.frame.origin, size: size)
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
    
    private func setupGeolocation() {
        geolocation.delegate = self
        geolocation.startLocationManager()
    }
    
    @IBAction private func updateLocation(_ sender: UIBarButtonItem) {
    }
}

extension WeatherScreenViewController: GeolocationDelegate {
    func locationServicesDisabled() {
        print("placeholder vse dela")
    }
    
    func authorizationDidChange(granted: Bool) {
        locationDenied = !granted
        print("autorization ignored")
    }
}
