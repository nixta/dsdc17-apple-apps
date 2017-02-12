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

        map = AGSMap(basemapType: .darkGrayCanvasVector, latitude: 38.913, longitude: -77.0499, levelOfDetail: 13)

        let embassiesTable = AGSServiceFeatureTable(url: URL(string: "https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Facility_and_Structure/MapServer/3")!)
        let embassies = AGSFeatureLayer(featureTable: embassiesTable)
        map.operationalLayers.add(embassies)
        
        embassies.renderer = AGSSimpleRenderer(symbol: AGSSimpleMarkerSymbol(style: .circle, color: UIColor.orange.withAlphaComponent(0.75), size: 8))
        
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
