//
//  NoInternetViewModel.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class NoInternetViewModel: SettingsPlaceholderViewModel {
    var kind: PlaceholderKind? = PlaceholderKind.noInternet
    var title: String = PlaceholderTitle.noInternet.rawValue
    var description: String? = PlaceholderKind.noInternet.rawValue
    var button: String? = nil
    var image: UIImage? = UIImage(named: "CloudNoInternet")
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

