//
//  Animations.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 27.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class Animations {
    
    func startRotateAnimation(imageView: UIImageView,
                              circleTime: Double,
                              repeatCount: Float = .infinity) {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = Double.pi * 2 // Minus or plus is a direction of rotation
        rotation.duration = 0.7
        rotation.repeatCount = repeatCount
        imageView.layer.add(rotation, forKey: nil)
    }
    
    
//Work in progress
    
    //        placeholderView.placeholderImageView.transform = CGAffineTransform(translationX: 500, y: 0)
    //        placeholderView.placeholderImageView.alpha = 0
    //        UIView.animate(withDuration: 3, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
    //            placeholderView.placeholderImageView.transform = .identity
    //            placeholderView.placeholderImageView.alpha = 1
    //        })
            
    
}
