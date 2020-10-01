//
//  MainTableViewCell.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var weatherStatusImageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var maxCurrentTempLabel: UILabel!
    @IBOutlet weak var minCurrentTempLabel: UILabel!
}
