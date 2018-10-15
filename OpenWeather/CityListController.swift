//
//  CityListController.swift
//  OpenWeather
//
//  Created by Satish Mavani on 10/14/18.
//  Copyright © 2018 SM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CityListController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let cityList = CityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCityAction(_ sender: UIBarButtonItem) {
    
        let locationPicker = LocationPickerViewController()
        
        // ignored if initial location is given, shows that location instead
        locationPicker.showCurrentLocationInitially = true // default: true
        
        locationPicker.completion = { location in
            // do some awesome stuff with location
            if let loc = location {
                self.cityList.addToHistory(loc)
                self.refresh()
            }
        }
        
        navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.table.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenWeather" {
            
        }
    }
}

extension CityListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell,
            let city = cityList.location(at: indexPath.row) {
            cell.textLabel?.text = city.name
            print(city)
            return cell
        }
        
        // Should well test at developmet time
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete,
            let city = cityList.location(at: indexPath.row) {
            cityList.reomveThis(city)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}

extension CityListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let city = cityList.location(at: indexPath.row),
            let weatherVC = self.storyboard?.instantiateViewController(withIdentifier: "WeatherVC") as? WeatherVC {
            weatherVC.location = city
            self.navigationController?.present(weatherVC, animated: true, completion: nil)
        }
    }
}
