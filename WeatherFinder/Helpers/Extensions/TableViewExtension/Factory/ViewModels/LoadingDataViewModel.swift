//
//  LoadingDataViewModel.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class LoadingDataViewModel: SettingsPlaceholderViewModel {
    var kind: PlaceholderKind? = PlaceholderKind.loadingData
    var title: String = PlaceholderTitle.loadingData.rawValue
    var description: String? = nil
    var button: String? = nil
    var image: UIImage? = UIImage(named: "SunSpinner")
    var animationFunction: ((UIImageView) -> ())?
    private let animations = Animations()
    
    init() {
        animationFunction = { [weak self] imageView in
            if let self = self {
                self.animations.startRotateAnimation(imageView: imageView)
            }
        }
    }
}

