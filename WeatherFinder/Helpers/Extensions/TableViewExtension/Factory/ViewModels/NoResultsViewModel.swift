//
//  NoResultsViewModel.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class NoResultsViewModel: SettingsPlaceholderViewModel {
    var kind: PlaceholderKind? = PlaceholderKind.noResults
    var title: String = PlaceholderTitle.noResults.rawValue
    var description: String? = PlaceholderKind.noResults.rawValue
    var button: String? = nil
    var image: UIImage? = UIImage(named: "RainbowNoResults")
    var animationFunction: ((UIImageView) -> ())?
    private let animations = Animations()
    
    init() {
        animationFunction = { [weak self] imageView in
            if let self = self {
                self.animations.startUnfadeAnimation(imageView: imageView)
            }
        }
    }
}
