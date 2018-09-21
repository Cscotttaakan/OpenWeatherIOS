//
//  ViewController.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    //UI
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentCityTemp: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var specialBG: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //Constants
    let locationManager = CLLocationManager()
    
    //Variables
    var currentWeather : CurrentWeather!
    var currentLocation : CLLocation!
    var forecastWeather : ForecastWeather!
    var forecastArray : [ForecastWeather] = [ForecastWeather]()
    
    
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
        downloadForecastWeather {
            print("Data Downloaded")
        }
    }
    
    func callDelegate(){
        locationManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK : Location
    func setUpLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() //Request Permission
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func downloadForecastWeather(completed: @escaping DownloadComplete ){
        Alamofire.request(FORECAST_API_URL).responseJSON { (response) in
            let result = response.result
            
            if let dictionary = result.value as? [String : Any] {
                if let list = dictionary[JSONConstants.forecastList] as? [[String : Any]] {
                    for item in list {
                        let forecast = ForecastWeather(weatherDict: item)
                        self.forecastArray.append(forecast)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func locationAuthCheck(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //Get location from device
            if let currentLocation = locationManager.location{
            
            //Pass location coord to our API
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //Download API Data
            currentWeather.downloadCurrentWeather {
                //Update after UI download is complete
                self.updateUI()
                
            }
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
                self.currentCityTemp.text = "\(Int(self.currentWeather._currentTemp!))°"
                self.currentDate.text = self.currentWeather._date
                self.weatherType.text = self.currentWeather._weatherType
            }
        }
        
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.forecastCellID) as! ForecastCell
        cell.configureCell(forecastData: forecastArray[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
   
    
    
}
