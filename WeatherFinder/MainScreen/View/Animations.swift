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
                              circleTime: Double = 0.8,
                              repeatCount: Float = .infinity,
                              duration: Double = 0.7) {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = Double.pi * 2 // Minus or plus is a direction of rotation
        rotation.duration = duration
        rotation.repeatCount = repeatCount
        imageView.layer.add(rotation, forKey: nil)
    }
    
    func startUnfadeAnimation(imageView: UIImageView,
                              alpha: Double = 0.0,
                              duration: Double = 3.0,
                              delay: Double = 0.5) {
        imageView.alpha = CGFloat(alpha)
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseOut,
                       animations: {
                            imageView.alpha = 1
                       },
                       completion: nil)
    }
    
    func startBouncingAnimation(imageView: UIImageView,
                                duration: Double = 1.0,
                                delay: Double = 0.5,
                                springWithDamping: CGFloat = 0.2,
                                springVelocity: CGFloat = 10) {
        let bounds = imageView.bounds
        let changedBounds = CGRect(x: bounds.origin.x - 20,
                                   y: bounds.origin.y - 20,
                                   width: bounds.size.width + 40,
                                   height: bounds.size.height + 40)
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: springWithDamping,
                       initialSpringVelocity: springVelocity,
                       options: .curveEaseInOut,
                       animations: {
                            imageView.bounds = changedBounds
        }) { (sucess: Bool) in
            imageView.bounds = bounds
        }
    }
}
