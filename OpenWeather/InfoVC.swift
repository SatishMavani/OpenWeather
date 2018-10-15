//
//  InfoVC.swift
//  OpenWeather
//
//  Created by Satish Mavani on 10/15/18.
//  Copyright © 2018 SM. All rights reserved.
//

import UIKit
import WebKit

class InfoVC: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let html =
"""
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<h1>- Add city by long press on map and then by click on select</h1>
<h1>- Weather details screen for 1 weeks weather details</h1>
<h1>- In CityList Screen swipe city left to remove it from bookmark</h1>

</body>
</html>
"""
        webView.loadHTMLString(html, baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
