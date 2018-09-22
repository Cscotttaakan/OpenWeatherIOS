//
//  ForecastCell.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import UIKit
import Alamofire

class ForecastCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var forecastDay: UILabel!
    @IBOutlet weak var forecastTemp: UILabel!
    @IBOutlet weak var forecastIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected,animated: animated)
    }
    
    func configureCell(forecastData : ForecastWeather){
        
        /*let url = "\(WEATHER_ICON_URL)\(forecastData._iconID!).png"
        print(url)
        self.forecastIcon.load(url: URL(string: url)!) */
        
        DispatchQueue.main.async {
        self.forecastIcon.image = UIImage(named: forecastData._iconID!)
        self.forecastDay.text = "\(forecastData._date!)"
        self.forecastTemp.text = "\(Int(forecastData._temp ?? 0))°"
        
        }
    }

}
