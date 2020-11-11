import UIKit
import CoreLocation

class WeatherScreenViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // TODO: resolve variable searchController initialization issue
    private var searchController: UISearchController?
    private let gradientLayer = Colors.gradientLayer
    private let geolocation = Geolocation()
    private var dailyCityWeaterData: DailyWeather?
    private var cityWeatherData: WeatherDataModel? = nil {
        willSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        refresh()
        setupTableView()
        setupGeolocation()
        NotificationCenter.default.addObserver(self, selector: #selector(setupGeolocation),
                                               name: UIScene.didActivateNotification, object: nil)
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

    private func setupTableView() {
        let cityWeatherNib = UINib(nibName: "CityWeatherTableViewCell", bundle: nil)
        let dailyPickerNib = UINib(nibName: "DailyWeatherPickerTableViewCell", bundle: nil)
        tableView.register(cityWeatherNib, forCellReuseIdentifier: "CityWeatherTableViewCell")
        tableView.register(dailyPickerNib, forCellReuseIdentifier: "DailyWeatherPickerTableViewCell")
    }

    @objc private func setupGeolocation() {
        geolocation.delegate = self
        cityWeatherData = nil
        geolocation.checkAuthorizationStatus()
    }

    @IBAction private func updateLocation(_ sender: UIBarButtonItem) {
        setupGeolocation()
    }
}

// MARK: - Extension Geolocation Delegate
extension WeatherScreenViewController: GeolocationDelegate {
    func authorizationStatusSetup(state: CurrentAutorizationStatus) {
        cityWeatherData = nil
        switch state {
        case .geolocationAllowed:
            tableView.restoreTableView(separatorStyle: .none)
        case .geolocationDenied:
            tableView.setPlaceholder(kind: .geolocationDenied)
        case .geolocationOff:
            tableView.setPlaceholder(kind: .geolocationOff)
        }
    }

    func locationRecieved(location: CLLocation?) {
        tableView.setPlaceholder(kind: .loadingData)
        //This method is called for testing purposes, it must be deleted after NetworkManager is implemented, it's better to implement this method on promiseKit
        NetworkManager.shared.getCityWeatherByCoordinates(coordinates: location) { [weak self] cityWeather in
            if let cityWeather = cityWeather, let self = self {
                self.cityWeatherData = cityWeather
                NetworkManager.shared.getDailyWeatherByCoordinates(coordinates: location) { (dailyCityWeather) in
                    if let dailyCityWeather = dailyCityWeather {
                        self.dailyCityWeaterData = dailyCityWeather
                        self.tableView.restoreTableView(separatorStyle: .none)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: - Extension TableView Datasource
extension WeatherScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard cityWeatherData != nil && dailyCityWeaterData != nil else { return 0 }
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeue(DailyWeatherPickerTableViewCell.self, for: indexPath)
            cell.dailyWeather = dailyCityWeaterData
            return cell
        case 1:
            let cell = tableView.dequeue(CityWeatherTableViewCell.self, for: indexPath)
            if let weatherData = cityWeatherData {
                cell.updateWeatherData(model: weatherData)
            }
            return cell
        default:
            fatalError("Cells quantity error in WeatherScreenViewController tableView")
        }
    }
}
