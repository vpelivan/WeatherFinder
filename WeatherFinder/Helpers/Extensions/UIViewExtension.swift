//
//  UIViewExtension.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 09.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

extension UIView {
    func getViewFromXib(nibName: String) -> UIView {
        guard let viewFromXib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("Unable to load view from xib")
        }
        return viewFromXib
    }
}
