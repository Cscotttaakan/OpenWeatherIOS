//
//  ViewController.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {
    //UI
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentCityTemp: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var specialBG: UIImageView!
    
    //Constants
    let locationManager = CLLocationManager()
    
    //Variables
    var currentWeather : CurrentWeather!
    var currentLocation : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyEffect()
        callDelegate()
        setUpLocation()

        currentWeather = CurrentWeather()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        locationAuthCheck()
    }
    
    func callDelegate(){
        locationManager.delegate = self
    }
    
    // MARK : Location
    func setUpLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() //Request Permission
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationAuthCheck(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //Get location from device
            currentLocation = locationManager.location
            
            //Pass location coord to our API
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //Download API Data
            currentWeather.downloadCurrentWeather {
                //Update after UI download is complete
                self.updateUI()
            }
            
            }else{ //User did not allow
            locationManager.requestWhenInUseAuthorization() //Request permission again
            locationAuthCheck() //Check for permission
            }
        }
        
        // MARK : Animations
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
        
        
        // MARK : UI
        func updateUI(){
            DispatchQueue.main.async {
                self.cityName.text = self.currentWeather._cityName
                self.currentCityTemp.text = "\(Int(self.currentWeather._currentTemp!))"
                self.currentDate.text = self.currentWeather._date
                self.weatherType.text = self.currentWeather._weatherType
            }
        }
        
}

