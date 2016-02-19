//
//  arc.swift
//  arc
//
//  Created by Tom MacWright on 2/19/16.
//  Copyright © 2016 Tom MacWright. All rights reserved.
//

import Foundation
import CoreLocation

func interpolate(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, f: Float, g: Float) -> CLLocationCoordinate2D {
    let A = sin((1 - f) * g) / sin(g);
    var B = sin(f * g) / sin(g);
    var x = A * cos(start.latitude as Double) * cos(start.longitude) + B * cos(end.latitude) * cos(end.longitude);
    var y = A * cos(start.latitude) * sin(start.longitude) + B * cos(end.latitude) * sin(end.longitude);
    var z = A * sin(start.latitude) + B * Math.sin(end.latitude);
    var lat = R2D * atan2(z, sqrt(pow(x, 2) + pow(y, 2)));
    var lon = R2D * atan2(y, x);
    return [lon, lat];
    return start;
}

func greatCircle(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, points: Int) -> Bool {
    let width = start.longitude - end.longitude;
    let height = start.latitude - end.latitude;
    let z = pow(sin(height / 2.0), 2) +
        cos(start.latitude) *
        cos(end.latitude) *
        pow(sin(width / 2.0), 2);
    let g = 2.0 * asin(sqrt(z));
    
    var first_pass: [CLLocationCoordinate2D] = [];
    var delta = 1.0 / (Float(points) - 1.0);
    for i in 0...points {
        first_pass.append(interpolate(start, end: end, f: delta * Float(i), g: g));
    }
    
    return true;
}