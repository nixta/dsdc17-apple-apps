//
//  ViewController.swift
//  DevSummitDemo
//
//  Created by Nicholas Furness on 2/8/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var mapView: AGSMapView!
    
    var locator = AGSLocatorTask(url: URL(string:"https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")!)

    override func viewDidLoad() {
        super.viewDidLoad()

        let map = AGSMap(basemapType: .topographic, latitude: 38.913, longitude: -77.0499, levelOfDetail: 3)
        
        mapView.map = map
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            
            locator.geocode(withSearchText: searchText) { (results, error) in
                guard error == nil else {
                    print("Error geocoding! \(error!)")
                    return
                }
                
                if let targetExtent = results?.first?.extent {
                    self.mapView.setViewpoint(AGSViewpoint(targetExtent: targetExtent))
                }
            }
        }
    }
}

