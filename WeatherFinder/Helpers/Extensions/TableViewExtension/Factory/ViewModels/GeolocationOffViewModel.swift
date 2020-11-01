//
//  GeolocationOffViewModel.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class GeolocationOffViewModel: SettingsPlaceholderViewModel {
    var kind: PlaceholderKind? = PlaceholderKind.geolocationOff
    var title: String = PlaceholderTitle.geolocationOff.rawValue
    var description: String? = PlaceholderKind.geolocationOff.rawValue
    var button: String? = nil
    var image: UIImage? = UIImage(named: "LightningNoGeolocation")
    var animationFunction: ((UIImageView) -> ())?
    private let animations = Animations()
    
    init() {
        animationFunction = { [weak self] imageView in
            if let self = self {
                self.animations.startBouncingAnimation(imageView: imageView)
            }
        }
    }
}
