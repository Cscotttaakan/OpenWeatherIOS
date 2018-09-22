//
//  Constants.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import Foundation

struct UIConstants {
    static let xcenter : String = "center.x"
    static let ycenter : String = "center.y"
    static let intensity : Double = 45.0
    static let forecastCellID : String = "ForecastCell"
}

//For https://openweathermap.org/current API
//Look at API to modify JSONConstants
struct JSONConstants {
    static let city : String = "name"
    static let currentDate : String = "dt"
    static let weather : String = "weather"
    static let weatherType : String = "main"
    static let main : String = "main"
    static let temperature : String = "temp"
    static let forecastList : String = "list"
    static let day : String = "day"
    static let icon : String = "icon"
}

struct APIConstants {
    static let weatherKey : String = "4d01fda49d461b6ee0d642809e24dd16"
}
