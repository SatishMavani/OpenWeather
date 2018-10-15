//
//  Constants.swift
//  OpenWeather
//
//  Created by Satish Mavani on 10/14/18.
//  Copyright © 2018 SM. All rights reserved.
//

    
import Foundation
    
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
    
var LATITUDE: String{
    return "lat=\(Loc.sharedInstance.latitude!)"
}
    
var LONGITUDE: String {
    return "&lon=\(Loc.sharedInstance.longitude!)"
}
    
var API_ID: String {
    return "&appid=\(API_KEY)"
}
    
let API_KEY = "7d93fa1fca5b9d823a05232e06a6df72"
    
typealias DownloadComplete = () -> ()
    
var CURRENT_WEATHER_URL: String{
    return "http://api.openweathermap.org/data/2.5/weather?\(LATITUDE)\(LONGITUDE)\(API_ID)"
}
    
var FORECAST_URL: String {
    return "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Loc.sharedInstance.latitude!)\(LONGITUDE)&cnt=10\(API_ID)"
}
