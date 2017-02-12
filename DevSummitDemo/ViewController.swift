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

    override func viewDidLoad() {
        super.viewDidLoad()

        let map = AGSMap(url: URL(string: "https://geeknixta.maps.arcgis.com/home/item.html?id=09f0c109352f488eafc82ba4e089686d")!)
        
        mapView.map = map
    }

}

