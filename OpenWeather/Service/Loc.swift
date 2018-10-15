//
//  Loc.swift
//  OpenWeather
//
//  Created by Satish Mavani on 10/14/18.
//  Copyright © 2018 SM. All rights reserved.
//

import CoreLocation

class Loc {
    static var sharedInstance = Loc()
    private init() {}
    
    var latitude : Double!
    var longitude : Double!
}
