//
//  ViewController.swift
//  DevSummitDemo
//
//  Created by Nicholas Furness on 2/8/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController, AGSGeoViewTouchDelegate, AGSPopupsViewControllerDelegate {

    @IBOutlet weak var mapView: AGSMapView!
    
    var map:AGSMap!

    override func viewDidLoad() {
        super.viewDidLoad()

        map = AGSMap(url: URL(string: "https://geeknixta.maps.arcgis.com/home/item.html?id=09f0c109352f488eafc82ba4e089686d")!)
        
        mapView.map = map
        
        mapView.touchDelegate = self
        
        mapView.interactionOptions.isMagnifierEnabled = false
    }

    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        mapView.identifyLayers(atScreenPoint: screenPoint, tolerance: 22, returnPopupsOnly: false, maximumResultsPerLayer: 10) { (results, error) in
            guard error == nil else {
                print("Error identifying the tap results! \(error!)")
                return
            }
            
            guard let result = results?.first else {
                return
            }
            
            let popupVC = AGSPopupsViewController(popups: result.popups)
            self.present(popupVC, animated: true, completion: nil)
            popupVC.delegate = self
        }
    }
    
    func popupsViewControllerDidFinishViewingPopups(_ popupsViewController: AGSPopupsViewController) {
        self.dismiss(animated: true, completion: nil)
    }

}

