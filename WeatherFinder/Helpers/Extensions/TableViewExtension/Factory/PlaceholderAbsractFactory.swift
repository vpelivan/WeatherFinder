//
//  PlaceholderAbsractFactory.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 01.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class PlaceholderFactory {
    
    private let placeholderView: PlaceholderView
   
    init (_ placeholderView: PlaceholderView) {
        self.placeholderView = placeholderView
    }
    
    func createPlaceholder(model: SettingsPlaceholderViewModel) -> PlaceholderView {
        placeholderView.updatePlaceholderViewData(model.title,
                                                  model.description,
                                                  model.button,
                                                  model.image)
        switch model.kind {
        case .loadingData:
            placeholderView.descriptionLabel.isHidden = true
        case .geolocationDenied:
            placeholderView.goToSettingsButton.isHidden = false
        case .noResults, .noInternet, .geolocationOff, .none:
            break
        }
        return placeholderView
    }
    
    func createModel(ofKind: PlaceholderKind) -> SettingsPlaceholderViewModel {
        switch ofKind {
        case .loadingData: return LoadingDataViewModel()
        case .noResults: return NoResultsViewModel()
        case .noInternet: return NoInternetViewModel()
        case .geolocationOff: return GeolocationOffViewModel()
        case .geolocationDenied: return GeolocationDeniedViewModel()
        }
    }
}
