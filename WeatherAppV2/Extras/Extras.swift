//
//  Extras.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import Foundation

let API_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(APIConstants.weatherKey)"
//let FORECAST_API_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=8&appid=\(APIConstants.weatherKey)"

let FORECAST_API_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=8&appid=7c609f73c5df2dff2f32e3e3cc33cd23"

typealias DownloadComplete = () -> ()

