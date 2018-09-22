//
//  CurrentWeather.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeather {
    
    private(set) var _cityName : String?
    private(set) var _date : String?
    private(set) var _weatherType : String?
    private(set) var _currentTemp : Double?
    private(set) var _weatherID : String?
    
    func downloadCurrentWeather(completed : @escaping DownloadComplete){
        
        Alamofire.request(API_URL).responseJSON { (response) in
            let result = response.result
            let json = JSON(result.value)
            
            self._cityName = json[JSONConstants.city].stringValue
            self._weatherType = json[JSONConstants.weather][0][JSONConstants.weatherType].stringValue
            
            let tempDate = json[JSONConstants.currentDate].double
            let convertedDate = Date(timeIntervalSince1970: tempDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: convertedDate)
            self._date = currentDate
            
            let downloadedTemp = json[JSONConstants.main][JSONConstants.temperature].double
            self._currentTemp = (downloadedTemp! - 273.15).celsiusToFahr().rounded(toPlaces: 0)
            
            let id = json[JSONConstants.weather][0][JSONConstants.icon].stringValue
            self._weatherID = id
            
            completed()
        }
    }
}
