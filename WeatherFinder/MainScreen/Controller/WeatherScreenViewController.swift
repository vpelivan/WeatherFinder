
import UIKit

class WeatherScreenViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // TODO: resolve variable searchController initialization issue
    private var searchController: UISearchController?
    private let gradientLayer = Colors.gradientLayer
    private let geolocation = Geolocation()
    private var locationDenied = false {
        willSet{
            print("set locationDenied to \(newValue)")
        }
    }
    private var cityWeatherData: WeatherDataModel? {
        // TODO: cityWeatherData must be computable and should call networkManager corresponding methods or geolocation methods.
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        refresh()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    private func setupTableView() {
        let nib = UINib(nibName: "CityWeatherTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "weatherCell")
        tableView.dataSource = self
    }
    
    @IBAction private func updateLocation(_ sender: UIBarButtonItem) {
    }
}

// MARK: - Extension realization
extension WeatherScreenViewController: GeolocationDelegate {
    
    //Здесь будут методы, которые будут вызывать плэйсхолдер, в зависимости от кейса.
    func authorizationAllowed() {
        geolocation.startLocationManager()
    }
    
    func authorizationDenied() {
//        tableView.setPlaceholder(ofKind: .geolocationDenied)
        print("Placeholder Geolocation Denied by User")
    }
    
    func switchOffPlaceholder() {
//        tableView.restoreTableView(separatorStyle: .none)
        print("Turn OFF Placeholder")
    }
    
    func locationServicesDisabled() {
//        tableView.setPlaceholder(ofKind: .geolocationOff)
        print("Placeholder Geolocation OFF")
    }
    
    func authorizationDidChange(granted: Bool) {
        locationDenied = !granted
//        tableView.setPlaceholder(ofKind: .geolocationDenied)
        print("Placeholder Geolocation Denied by User")
    }
    
    
}

extension WeatherScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? CityWeatherTableViewCell else {
            return UITableViewCell.init()
        }
        
        if let weatherData = cityWeatherData {
            cell.updateWeatherData(model: weatherData)
        }
        return cell
    }
}
