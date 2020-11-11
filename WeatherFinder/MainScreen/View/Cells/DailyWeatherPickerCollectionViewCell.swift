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
        toggleActivityIndicator(visible: true)
    }

    func updateDailyWeather(model: OneDayWeather) {
//        dateLabel.text =
        temperatureLabel.text = "%.f˚C".getLocalizedStringFromFormat(model.temperature)
        if model.weatherCondition.isEmpty == false {
            let weatherCondition = model.weatherCondition[0]?.description
            let iconId = model.weatherCondition[0]?.icon
            weatherStatusLabel.text = weatherCondition?.capitalized ?? "No Value".localized
            updateWeatherImage(iconId: iconId)
        }
    }

    private func updateWeatherImage(iconId: String?) {
        guard let iconId = iconId else {
            toggleActivityIndicator(visible: false)
            weatherImageView.image = UIImage(named: "NoImage")
            return
        }

        NetworkManager.shared.getWeatherImage(iconId: iconId) { [weak self] weatherImage in
            if let self = self {
                self.toggleActivityIndicator(visible: false)
                self.weatherImageView.image =
                    (weatherImage != nil ? weatherImage : UIImage(named: "NoImage"))
            }
        }
    }
}
