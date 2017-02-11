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

        let map = AGSMap(basemapType: .darkGrayCanvasVector, latitude: 38.913, longitude: -77.0499, levelOfDetail: 13)
        
        mapView.map = map
    }

}

