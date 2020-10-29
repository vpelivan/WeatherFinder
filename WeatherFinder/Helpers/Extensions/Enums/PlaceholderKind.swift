//
//  PlaceholderKind.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 28.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

enum PlaceholderKind: String {
    case loadingData
    case noResults = "City Not Found"
    case noInternet = "Please check the ability to connect to the internet and try again"
    case geolocationOff = "You can enable Location Services in settings of Your device. Otherwise the app won't be able to show Your current location weather automatically"
    case geolocationDenied = "Press Appliction Settings button to allow geolocation for this application manually. Otherwise the app won't be able to show Your current location weather automatically"
}

