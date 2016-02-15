//
//  ViewController.swift
//  Mapbox POI
//
//  Created by Tom MacWright on 2/12/16.
//  Copyright © 2016 Tom MacWright. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController {
    @IBOutlet weak var myMap: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.setCenterCoordinate(CLLocationCoordinate2D(latitude: 42.35852, longitude: -71.06094), zoomLevel: 8.0, animated: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}