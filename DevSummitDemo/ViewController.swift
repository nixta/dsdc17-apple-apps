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

        let embassiesTable = AGSServiceFeatureTable(url: URL(string: "https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Facility_and_Structure/MapServer/3")!)
        let embassies = AGSFeatureLayer(featureTable: embassiesTable)
        map.operationalLayers.add(embassies)
        
        mapView.map = map
    }

}

