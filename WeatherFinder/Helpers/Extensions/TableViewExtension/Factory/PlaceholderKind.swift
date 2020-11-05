//
//  PlaceholderKind.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 28.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

enum PlaceholderKind {
    case loadingData
    case noResults
    case noInternet
    case geolocationOff
    case geolocationDenied

    var title: String {
        switch self {
        case .loadingData: return "Loading Data"
        case .noResults: return "No Results Found"
        case .noInternet: return "No Internet Connection"
        case .geolocationOff: return "Geolocation Services Are Off"
        case .geolocationDenied: return "Geolocation Is Denied"
        }
    }

    var description: String? {
        switch self {
        case .loadingData: return nil
        case .noResults: return "City Not Found"
        case .noInternet: return "Please check the ability to connect to the internet and try again"
        case .geolocationOff: return "You can enable Location Services in settings of Your device. Otherwise the app won't be able to show Your current location weather automatically"
        case .geolocationDenied:
            return "Press Appliction Settings button to allow geolocation for this application manually. Otherwise the app won't be able to show Your current location weather automatically"
        }
    }

    var button: String? {
        switch self {
        case .loadingData, .noResults, .noInternet, .geolocationOff: return nil
        case .geolocationDenied: return "Application Settings"
        }
    }

    var image: UIImage? {
        switch self {
        case .loadingData: return UIImage(named: "SunSpinner")
        case .noResults: return UIImage(named: "RainbowNoResults")
        case .noInternet: return UIImage(named: "CloudNoInternet")
        case .geolocationDenied, .geolocationOff: return UIImage(named: "LightningNoGeolocation")
        }
    }

    var animationFunction: ((UIImageView) -> Void)? {
        let animations = Animations()
        switch self {
        case .loadingData: return { imageView in
            animations.startRotateAnimation(imageView: imageView)
        }
        case .noResults: return { imageView in
            animations.startUnfadeAnimation(imageView: imageView)
        }
        case .noInternet, .geolocationOff, .geolocationDenied: return { imageView in
            animations.startBouncingAnimation(imageView: imageView)
        }
        }
    }
}
