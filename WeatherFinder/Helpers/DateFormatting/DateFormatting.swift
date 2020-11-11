//
//  DateFormatting.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 11.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

class DateFormatting {
    func getStringDateFromTimeStamp(timeStamp: Double, dateFormat: String) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let stringFromDate = formatter.string(from: date)
        return stringFromDate
    }
}
