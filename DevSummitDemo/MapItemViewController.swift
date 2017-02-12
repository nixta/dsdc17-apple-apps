//
//  MapItemViewController.swift
//  DevSummitDemo
//
//  Created by Nicholas Furness on 2/12/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

class MapItemViewController: UIViewController {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var mapName: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var views: UILabel!
    
    public weak var map:AGSMap?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let mapItem = self.map?.item as? AGSPortalItem {

            mapItem.load { (error) in
                guard error == nil else {
                    print("Error loading item! \(error)")
                    return
                }
                
                let tagString = mapItem.tags.reduce("", { (currentTag, tagString) -> String in
                    return "\(tagString),\(currentTag)"
                }).trimmingCharacters(in: CharacterSet(charactersIn: ","))
                
                self.mapName.text = mapItem.title
                self.tags.text = tagString
                self.views.text = "\(mapItem.viewCount)"
                
            }
            
            mapItem.thumbnail?.load() { (error) in
                guard error == nil else {
                    print("Could not load thumbnail! \(error)")
                    return
                }
                
                self.thumbnailView.image = mapItem.thumbnail?.image
            }

        }
        
    }
}
