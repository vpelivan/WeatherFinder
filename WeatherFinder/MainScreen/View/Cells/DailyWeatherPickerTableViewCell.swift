//
//  DailyWeatherPickerTableViewCell.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 04.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class DailyWeatherPickerTableViewCell: UITableViewCell {
    @IBOutlet private weak var pickerCollectionView: UICollectionView!
    var dailyWeather: DailyWeather?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: "DailyWeatherPickerCollectionViewCell", bundle: nil)
        pickerCollectionView.register(nib, forCellWithReuseIdentifier: "DailyWeatherPickerCollectionViewCell")
        pickerCollectionView.dataSource = self
    }
}

extension DailyWeatherPickerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyWeather?.oneWeekWeather.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(DailyWeatherPickerCollectionViewCell.self, for: indexPath)
        if let oneDayWeather = dailyWeather?.oneWeekWeather[indexPath.row] {
            cell.updateDailyWeather(model: oneDayWeather)
        }
        return cell
    }
}

extension DailyWeatherPickerCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}
