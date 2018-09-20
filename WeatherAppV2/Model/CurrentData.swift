//
//  CurrentData.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeather {
    
    private var _cityName : String?
    private var _date : String?
    private var _weatherType : String?
    private var _currentTemp : Double?
    
    func downloadCurrentWeather(completed : @escaping DownloadComplete){
        Alamofire.request(API_URL).responseJSON { (response) in
            
            let result = response.result
            let json = JSON(result.value)
            self._cityName = json[JSONConstants.city].stringValue
            
        }
        completed()
    }
    
}
