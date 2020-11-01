//
//  SettingsPlaceholderViewModel.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

protocol SettingsPlaceholderViewModel {
    var kind: PlaceholderKind? { get }
    var title: String { get }
    var description: String? { get }
    var button: String? { get }
    var image: UIImage? { get }
    var animationFunction: ((UIImageView) -> ())? { get }
}
