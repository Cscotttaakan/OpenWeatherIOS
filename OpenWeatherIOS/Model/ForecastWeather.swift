//
//  ForecastWeather.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import Foundation
import Alamofire

class ForecastWeather {
    private(set) var _date : String?
    private(set) var _temp : Double?
    private(set) var _iconID : String?
    
    
    init(weatherDict : [String : Any]){
        if let temperature = weatherDict[JSONConstants.temperature] as? [String : Any] {
            if let dayTemp = temperature[JSONConstants.day] as? Double{
                let rawValue : Double = (dayTemp - 273.15).celsiusToFahr().rounded(toPlaces : 0)
                self._temp = rawValue
            }
        }
        
        if let date = weatherDict[JSONConstants.currentDate] as? Double {
            let rawDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self._date = "\(rawDate.dayOfTheWeek())"
        }
        
        
        
        if let list = weatherDict[JSONConstants.weather] as? [[String : Any]] {
            if let icon = list[0][JSONConstants.icon] as? String {
                self._iconID = icon
            }
        }
    }
}
