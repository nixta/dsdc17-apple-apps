//
//  ViewController+MapItem.swift
//  DevSummitDemo
//
//  Created by Nicholas Furness on 2/12/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

extension ViewController {

    func geoView(_ geoView: AGSGeoView, didLongPressAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        map.load { (error) in
            guard error == nil else {
                return
            }
            
            if self.map.item != nil {
                self.performSegue(withIdentifier: "showMapItem", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapItem", let mivc = segue.destination as? MapItemViewController {
            mivc.map = self.map
        }
    }
    
    @IBAction func closeMapItemView(segue:UIStoryboardSegue) {
        print("Map Item View closed.")
    }

}
