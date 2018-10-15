//
//  WeatherVC.swift
//  OpenWeather
//
//  Created by Satish Mavani on 10/14/18.
//  Copyright © 2018 SM. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTemoLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentWindSpeedLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var location: Location!
    
    var currentWeather : CurrentWeather!
    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    @IBAction func closeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        
        Loc.sharedInstance.latitude = location.coordinate.latitude
        Loc.sharedInstance.longitude = location.coordinate.longitude
        
        print(Loc.sharedInstance.latitude)
        print(Loc.sharedInstance.longitude)
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI()
            }
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.tableView.reloadData()
                }
                
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTemoLabel.text = "\(currentWeather.currentTemp)°"
        currentHumidityLabel.text = "Humidity \(currentWeather.currentHumidity)%"
        currentWindSpeedLabel.text = "Wind \(currentWeather.currentWind) km/h"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        print(currentWeather.weatherType)
        locationLabel.text = currentWeather.cityName
        print(currentWeather.cityName)
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    
}

