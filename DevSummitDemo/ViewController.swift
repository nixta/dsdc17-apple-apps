//
//  ViewController.swift
//  DevSummitDemo
//
//  Created by Nicholas Furness on 2/8/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController {

    @IBOutlet weak var mapView: AGSMapView!
    var map:AGSMap!
    
    var routeTask = AGSRouteTask(url: URL(string: "https://route.arcgis.com/arcgis/rest/services/World/Route/NAServer/Route_World")!)
    var defaultRouteTaskParameters:AGSRouteParameters?

    var routeGraphics = AGSGraphicsOverlay()

    override func viewDidLoad() {
        super.viewDidLoad()

        map = AGSMap(url: URL(string: "https://geeknixta.maps.arcgis.com/home/item.html?id=09f0c109352f488eafc82ba4e089686d")!)
        
        mapView.map = map
        
        mapView.locationDisplay.autoPanMode = .recenter
        mapView.locationDisplay.initialZoomScale = 50000
        mapView.locationDisplay.start { (error) in
            guard error == nil else {
                print("Error starting location services! \(error)")
                return
            }
        }

        setupRouting()
    }
    
}
