//
//  CityWeatherTableViewCell.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit


final class CityWeatherTableViewCell: UITableViewCell, ActivityIndicatorProtocol {
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var weatherConditionLabel: UILabel!
    @IBOutlet private weak var weatherStatusImageView: UIImageView!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var maximumCurrentTemperatureLabel: UILabel!
    @IBOutlet private weak var minimumCurrentTemperatureLabel: UILabel!
<<<<<<< HEAD
    @IBOutlet private weak var imageActivityIndicator: UIActivityIndicatorView!
=======
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        toggleActivityIndicator(visible: true)
    }
>>>>>>> 275eb1512f481bbed776bfb4dc2a22f9b3f22a38
    
    func updateWeatherData(model: WeatherDataModel) {
        
        let currentTemperature = model.mainWeatherInfo?.temperature
        let feelsLikeTemperature = model.mainWeatherInfo?.feelsLike
        let pressure = model.mainWeatherInfo?.pressure
        let humidity = model.mainWeatherInfo?.humidity
        let windSpeed = model.windSpeed?.speed
        let maximumCurrentTemperature = model.mainWeatherInfo?.temperatureMaximum
        let minimumCurrentTemperature = model.mainWeatherInfo?.temperatureMinimum
        
        cityLabel.text = model.nameOfCity
        temperatureLabel.text = "%.f˚C".getLocalizedStringFromFormat(currentTemperature)
        feelsLikeLabel.text = "Feels Like: %.f˚C".getLocalizedStringFromFormat(feelsLikeTemperature)
        pressureLabel.text = "Pressure: %d mm".getLocalizedStringFromFormat(pressure)
        humidityLabel.text = "Humidity: %d %%".getLocalizedStringFromFormat(humidity)
        windSpeedLabel.text = "Wind Speed: %.f m/s".getLocalizedStringFromFormat(windSpeed)
        maximumCurrentTemperatureLabel.text =
            "Maximum Current Temperature: %.f˚C".getLocalizedStringFromFormat(maximumCurrentTemperature)
        minimumCurrentTemperatureLabel.text =
            "Minimum Current Temperature: %.f˚C".getLocalizedStringFromFormat(minimumCurrentTemperature)
        if model.weatherCondition.isEmpty == false {
            let weatherCondition = model.weatherCondition[0]?.description
            let iconId = model.weatherCondition[0]?.icon
            
            weatherConditionLabel.text = weatherCondition?.capitalized ?? "No Value".localized
            updateWeatherImage(iconId: iconId)
        }
    }
    
    private func updateWeatherImage(iconId: String?) {
        guard let iconId = iconId else {
            weatherStatusImageView.image = UIImage(named: "NoImage")
            return
        }
        
        NetworkManager.shared.getWeatherImage(iconId: iconId) { (weatherImage) in
            guard let weatherImage = weatherImage else {
                self.weatherStatusImageView.image = UIImage(named: "NoImage")
                return
            }
            self.toggleActivityIndicator(visible: false)
            self.weatherStatusImageView.image = weatherImage
        }
    }
}
