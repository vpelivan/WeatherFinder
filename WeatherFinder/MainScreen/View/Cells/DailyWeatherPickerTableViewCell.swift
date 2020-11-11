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
    private let dailyWeather: DailyWeather? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: "DailyWeatherPickerCollectionViewCell", bundle: nil)
        pickerCollectionView.register(nib, forCellWithReuseIdentifier: "dailyPickerCollectionCell")
        pickerCollectionView.dataSource = self
    }
}

extension DailyWeatherPickerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyWeather?.oneWeekWeather.count ?? 7 //change later
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyPickerCollectionCell", for: indexPath) as? DailyWeatherPickerCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension DailyWeatherPickerCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
