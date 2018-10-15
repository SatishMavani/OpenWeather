//
//  CurrentWeather.swift
//  OpenWeather
//
//  Created by Satish Mavani on 10/14/18.
//  Copyright © 2018 SM. All rights reserved.
//


import UIKit
import Alamofire

class CurrentWeather {
    var _cityName : String!
    var _date : String!
    var _weatherType : String!
    var _currentTemp : Double!
    var _currentHumidity : Double!
    var _currentWind : Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = "no type avalible"
        }
        return _weatherType
    }
    
    var currentTemp : Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var currentHumidity : Double {
        if _currentHumidity == nil {
            _currentHumidity = 0.0
        }
        return _currentHumidity
    }
    
    var currentWind : Double {
        if _currentWind == nil {
            _currentWind = 0.0
        }
        return _currentWind
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Download Current Weather Data
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                    
                }
                
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let currentSpeed = wind["speed"] as? Double {
                        self._currentWind = currentSpeed
                        print(self._currentWind)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        let kelvinToCelsius = (currentTemperature - 273.15)
                        
                        let roundCelsiusTemp = Double(round(10 * kelvinToCelsius/10))
                        
                        self._currentTemp = roundCelsiusTemp
                        print(self._currentTemp)
                    }
                    
                    if let currentHumidity = main["humidity"] as? Double {
                        self._currentHumidity = currentHumidity
                        print(self._currentHumidity)
                    }
                }
            }
            completed()
        }
    }
}


