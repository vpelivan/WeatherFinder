//
//  ActivityIndicatorProtocol.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 22.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityIndicatorProtocol {
    var activityIndicator: UIActivityIndicatorView! { get }
}

extension ActivityIndicatorProtocol {
    func toggleActivityIndicator(visible: Bool) {
        activityIndicator.isHidden = visible
        activityIndicator.isHidden ?
            activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
}
