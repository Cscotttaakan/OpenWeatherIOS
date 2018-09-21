//
//  ForecastCell.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var forecastDay: UILabel!
    @IBOutlet weak var forecastTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected,animated: animated)
    }
    
    func configureCell(forecastData : ForecastWeather){
        DispatchQueue.main.async {
        self.forecastDay.text = "\(forecastData._date!)"
        self.forecastTemp.text = "\(Int(forecastData._temp ?? 0))°"
        }
    }

}
