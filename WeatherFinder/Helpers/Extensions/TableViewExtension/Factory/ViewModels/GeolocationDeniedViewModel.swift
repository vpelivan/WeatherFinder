//
//  GeolocationDeniedViewModel.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class GeolocationDeniedViewModel: SettingsPlaceholderViewModel {
    var kind: PlaceholderKind? = PlaceholderKind.geolocationDenied
    var title: String = PlaceholderTitle.geolocationDenied.rawValue
    var description: String? = PlaceholderKind.geolocationDenied.rawValue
    var button: String? = PlaceholderButton.geolocationDenied.rawValue
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
