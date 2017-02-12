//
//  ViewController.swift
//  DevSummitDemo
//
//  Created by Nicholas Furness on 2/8/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController, AGSGeoViewTouchDelegate, AGSCalloutDelegate, AGSPopupsViewControllerDelegate {

    @IBOutlet weak var mapView: AGSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let map = AGSMap(url: URL(string: "https://geeknixta.maps.arcgis.com/home/item.html?id=09f0c109352f488eafc82ba4e089686d")!)
        
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
                self.mapView.callout.dismiss()
                return
            }
            
            self.mapView.callout.title = embassy.attributes["COUNTRY"] as? String
            self.mapView.callout.detail = embassy.attributes["TELEPHONE"] as? String
            
            self.mapView.callout.show(for: embassy, tapLocation: mapPoint, animated: true)
            
            self.mapView.callout.delegate = self
        }
    }
    
    func didTapAccessoryButton(for callout: AGSCallout) {
        if let embassy = callout.representedObject as? AGSFeature {
            let popup = AGSPopup(geoElement: embassy, popupDefinition: embassy.featureTable?.featureLayer?.popupDefinition)
            let popupVC = AGSPopupsViewController(popups: [popup])
            self.present(popupVC, animated: true, completion: nil)
            popupVC.delegate = self
        }
    }
    
    func popupsViewControllerDidFinishViewingPopups(_ popupsViewController: AGSPopupsViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

