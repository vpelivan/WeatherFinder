//
//  CollectionViewExtension.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 11.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not deque cell with type \(T.self)")
        }
        return cell
    }
}
