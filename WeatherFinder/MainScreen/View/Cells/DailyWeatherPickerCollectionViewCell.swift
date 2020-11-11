//
//  DailyWeatherPickerCollectionViewCell.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 04.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class DailyWeatherPickerCollectionViewCell: UICollectionViewCell, ActivityIndicatorProtocol {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text?.removeAll()
        temperatureLabel.text?.removeAll()
        weatherStatusLabel.text?.removeAll()
        weatherImageView.image = nil
        toggleActivityIndicator(visible: false)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateDailyWeather(model: OneDayWeather) {
//        dateLabel.text =
        temperatureLabel.text = "%.f˚C".getLocalizedStringFromFormat(model.temperature)
        if model.weatherCondition.isEmpty == false {
            let weatherCondition = model.weatherCondition[0]?.description
            let iconId = model.weatherCondition[0]?.icon
            weatherStatusLabel.text = weatherCondition?.capitalized ?? "No Value".localized
            
        }
    }
}
