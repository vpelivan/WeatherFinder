//
//  CityWeatherTableViewCell.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {

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
    
    //TODO: declare NetworkManager class example, to reach "getWeatherImage(iconId: String, completion: @escaping (UIImage) -> ())" method (task: https://trello.com/c/fKkoSAWB)
    
    //TODO: current method must be implemented in task: https://trello.com/c/4Wjbg7Ph
    public func fetchWeatherData(/* model: CityWeather */) {
        /* inside this method, depending on current model data, all
         appropriate model values must be assigned in UI Elemets values;
         current method should call
         "getWeatherImage(iconId: String, completion: @escaping (UIImage) -> ())"
         from NetworkManager, and assign an image to weatherStatusImageView
         via escaping closure
        */
    }
}
