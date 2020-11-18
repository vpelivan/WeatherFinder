//
//  SearchCityTableViewController.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 17.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class SearchCityTableViewController: UITableViewController {

    var searchResult: WeatherDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult != nil ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoundCityTableViewCell", for: indexPath) as? FoundCityTableViewCell else {
            return FoundCityTableViewCell()
        }
        if let searchResult = searchResult {
            cell.updateCityLabel(with: searchResult)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let searchResult = searchResult,
           let weatherScreenVC = storyboard?.instantiateViewController(withIdentifier: "WeatherScreenViewController") as? WeatherScreenViewController {
            weatherScreenVC.cityWeatherData = searchResult
            performSegue(withIdentifier: "unwindToWeatherScreenFromSearch", sender: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func setupTableView() {
        let nibName = String(describing: FoundCityTableViewCell.self)
        let foundCityNib = UINib(nibName: nibName, bundle: nil)
        tableView.register(foundCityNib, forCellReuseIdentifier: nibName)
        tableView.separatorStyle = .none
    }

    private func performSearch(text: String?) {
        guard let textLength = text?.count,
              let text = text else { return }
        if text != "" && textLength > 2 {
            searchResult = nil
            NetworkManager.shared.getCityWeatherByName(name: text.replacingOccurrences(of: " ", with: "")) { [weak self] (weatherData) in
                if let self = self {
                    if let weatherData = weatherData {
                        self.searchResult = weatherData
                        self.tableView.restoreTableView(separatorStyle: .none)
                    } else {
                        self.tableView.setPlaceholder(kind: .noResults)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension SearchCityTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        performSearch(text: searchController.searchBar.text)
    }
}

extension SearchCityTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch(text: searchBar.text)
    }
}
