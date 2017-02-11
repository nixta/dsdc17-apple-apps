//
//  ViewController.swift
//  DevSummitDemo
//
//  Created by Nicholas Furness on 2/8/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController, AGSGeoViewTouchDelegate {

    @IBOutlet weak var mapView: AGSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let map = AGSMap(basemapType: .darkGrayCanvasVector, latitude: 38.913, longitude: -77.0499, levelOfDetail: 13)

        let embassiesTable = AGSServiceFeatureTable(url: URL(string: "https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Facility_and_Structure/MapServer/3")!)
        let embassies = AGSFeatureLayer(featureTable: embassiesTable)
        map.operationalLayers.add(embassies)
        
        embassies.renderer = AGSSimpleRenderer(symbol: AGSSimpleMarkerSymbol(style: .circle, color: UIColor.orange.withAlphaComponent(0.75), size: 8))
        
        mapView.map = map
        
        mapView.touchDelegate = self
    }

    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        mapView.identifyLayers(atScreenPoint: screenPoint, tolerance: 22, returnPopupsOnly: false) { (results, error) in
            guard error == nil else {
                print("Error identifying the tap results! \(error!)")
                return
            }
            
            guard let result = results?.first, let embassy = result.geoElements.first as? AGSFeature else {
                return
            }
            
            self.mapView.callout.title = embassy.attributes["COUNTRY"] as? String
            self.mapView.callout.detail = embassy.attributes["TELEPHONE"] as? String
            
            self.mapView.callout.show(for: embassy, tapLocation: mapPoint, animated: true)
        }
    }
}

