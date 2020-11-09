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

    func getConfiguredPlaceholder(from model: SettingsPlaceholderViewModel) -> PlaceholderView {
        placeholderView.updatePlaceholderViewData(viewModel: model)
        return placeholderView
    }
}
