//
//  ViewController.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    //UI
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentCityTemp: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var specialBG: UIImageView!
    
    //Variables
    var currentWeather : CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyEffect()
        currentWeather = CurrentWeather()
        currentWeather.downloadCurrentWeather {
            print("Download Complete")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func applyEffect(){
        specialEffect(view : specialBG , intensity: UIConstants.intensity)
        specialEffect(view : weatherImage , intensity : -UIConstants.intensity)
    }
    
    func specialEffect(view : UIView , intensity : Double) {
        let horizontalMotion = UIInterpolatingMotionEffect(keyPath: UIConstants.xcenter , type: .tiltAlongHorizontalAxis)
        horizontalMotion.minimumRelativeValue = -intensity
        horizontalMotion.maximumRelativeValue = intensity
        
        let verticalMotion = UIInterpolatingMotionEffect(keyPath: UIConstants.ycenter , type: .tiltAlongVerticalAxis)
        verticalMotion.minimumRelativeValue = -intensity
        verticalMotion.maximumRelativeValue = intensity
        
        let movement = UIMotionEffectGroup()
        movement.motionEffects = [horizontalMotion , verticalMotion]
        
        view.addMotionEffect(movement)
        
    }
    
}

