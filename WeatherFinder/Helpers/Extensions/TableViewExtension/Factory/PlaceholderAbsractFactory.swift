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

    func configurePlaceholder(with model: SettingsPlaceholderViewModel) -> PlaceholderView {
        placeholderView.updatePlaceholderViewData(viewModel: model)
        return placeholderView
    }

    func createModel(ofKind: PlaceholderKind) -> SettingsPlaceholderViewModel {
        return PlaceholderViewModel(kind: ofKind)
    }
}
