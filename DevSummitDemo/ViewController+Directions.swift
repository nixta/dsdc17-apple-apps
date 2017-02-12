//
//  ViewController+Directions.swift
//  DevSummitDemo
//
//  Created by Nicholas Furness on 2/11/17.
//  Copyright © 2017 Esri. All rights reserved.
//

import UIKit
import ArcGIS

extension ViewController: AGSGeoViewTouchDelegate {

    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        
        if let params = defaultRouteTaskParameters, let startPt = mapView.locationDisplay.mapLocation {
            
            // Set the start and end for the route.
            let stops = [startPt,mapPoint].map { ptGeom in
                return AGSStop(point: ptGeom)
            }
            stops.first?.name = "your location"
            stops.last?.name = "your destination"
            params.setStops(stops)
            
            // Solve the route.
            routeTask.solveRoute(with: params) { (routeResult, error) in
                guard error == nil else {
                    print("Error solving route! \(error)")
                    return
                }
                
                if let route = routeResult?.routes.first {
                    // Display the route.
                    self.routeGraphics.graphics.removeAllObjects()
                    self.routeGraphics.graphics.add(AGSGraphic(geometry: route.routeGeometry, symbol: nil, attributes: nil))
                    
                    if let newExtent = route.routeGeometry?.extent.toBuilder().expand(byFactor: 1.5).toGeometry() {
                        // Zoom to the route.
                        self.mapView.setViewpoint(AGSViewpoint(targetExtent: newExtent), completion: nil)
                    }
                    
                    self.printRoute(route)
                }
            }
            
        }
        
    }
    
    func printRoute(_ route:AGSRoute) {
        print("Route is \(AGSLinearUnit.meters().convert(route.totalLength, to: AGSLinearUnit.miles())) miles and will take \(route.totalTime) minutes")
        
        for maneuver in route.directionManeuvers {
            print("\(maneuver.directionText)")
        }
    }

    func setupRouting() {
        
        // Handle map taps
        mapView.touchDelegate = self
        
        // Set up a Graphics Overlay to show routes on the map.
        routeGraphics.renderer = AGSSimpleRenderer(symbol: AGSSimpleLineSymbol(style: .solid, color: UIColor.blue, width: 5))
        mapView.graphicsOverlays.add(routeGraphics)
        
        // Get the default parameters for the service.
        routeTask.defaultRouteParameters { (params, error) in
            guard error == nil else {
                print("Error getting default route parameters! \(error!)")
                return
            }
            
            if let defaultParams = params {
                print("Got default parameters!")
                // In all likelihood this will return immediately since both task and map will be loaded
                // already, but it's a convenient way to wait on both just in case.
                AGSLoadObjects([self.map, self.routeTask]) { (allLoaded) in
                    guard allLoaded else {
                        print("Something didn't load")
                        return
                    }
                    
                    // We waited on the map for the Spatial Reference.
                    defaultParams.outputSpatialReference = self.map.spatialReference
                    defaultParams.returnDirections = true
                    
                    print("Ready to route")
                    // We waited on the RouteTask so we know we have something to solve routes for us.
                    // Now, when self.defaultRouteTaskParameters is not nil, we know we can route.
                    self.defaultRouteTaskParameters = defaultParams
                }
            } else {
                print("The service returned no default parameters!")
                self.defaultRouteTaskParameters = AGSRouteParameters()
            }
        }
        
    }
}
