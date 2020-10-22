
import UIKit

class WeatherScreenViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // TODO: resolve variable searchController initialization issue
    private var searchController: UISearchController?
    private let gradientLayer = Colors.gradientLayer
    private var cityWeatherData: WeatherDataModel? {
        // TODO: cityWeatherData must be computable and should call networkManager corresponding methods or geolocation methods.
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        setupSearchController()
        refresh()
        setupTableView()
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
    
    private func setupTableView() {
        let nib = UINib(nibName: "CityWeatherTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "weatherCell")
        tableView.dataSource = self
    }
    
    @IBAction private func updateLocation(_ sender: UIBarButtonItem) {
    }
}

// MARK: Extension realization

extension WeatherScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? CityWeatherTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        }
        
        if let weatherData = cityWeatherData{
            cell.updateWeatherData(model: weatherData)
        }
        return cell
    }
}
