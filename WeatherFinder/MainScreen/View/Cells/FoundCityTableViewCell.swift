//
//  FoundCityTableViewCell.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 17.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

final class FoundCityTableViewCell: UITableViewCell {
    @IBOutlet private weak var foundCityLabel: UILabel!

    override func prepareForReuse() {
        foundCityLabel.text = nil
    }

    func updateCityLabel(with model: WeatherDataModel) {
        foundCityLabel.text = "\(model.nameOfCity.capitalized), \(model.countryCode?.code ?? "No Country Code".localized)"
    }
}
