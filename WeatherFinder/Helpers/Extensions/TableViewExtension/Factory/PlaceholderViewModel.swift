//
//  GeolocationOffViewModel.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class PlaceholderViewModel: SettingsPlaceholderViewModel {
    let kind: PlaceholderKind
    let title: String
    let description: String?
    let button: String?
    let image: UIImage?
    let animationFunction: ((UIImageView) -> Void)?

    init(kind: PlaceholderKind) {
        self.kind = kind
        self.title = kind.title
        self.description = kind.description
        self.button = kind.button
        self.image = kind.image
        self.animationFunction = kind.animationFunction
    }
}
