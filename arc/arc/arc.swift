//
//  arc.swift
//  arc
//
//  Created by Tom MacWright on 2/19/16.
//  Copyright © 2016 Tom MacWright. All rights reserved.
//

import Foundation
import CoreLocation

func degreesToRadians(deg: Double) -> Double {
    return deg * M_PI / 180.0;
}

func radiansToDegrees(rad: Double) -> Double {
    return rad * 180.0 / M_PI;
}

func interpolate(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, f: Double, g: Double) -> CLLocationCoordinate2D {
    let A = sin((1 - f) * g) / sin(g);
    let B = sin(f * g) / sin(g);
    let x = A * cos(start.latitude) *
        cos(start.longitude) + B *
        cos(end.latitude) *
        cos(end.longitude);
    let y = A * cos(start.latitude) *
        sin(start.longitude) + B *
        cos(end.latitude) *
        sin(end.longitude);
    let z = A * sin(start.latitude) + B *
        sin(end.latitude);
    return CLLocationCoordinate2D(
        latitude:  radiansToDegrees(atan2(z, sqrt(pow(x, 2) + pow(y, 2)))),
        longitude: radiansToDegrees(atan2(y, x)));
}

func greatCircle(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, points: Int) -> [CLLocationCoordinate2D] {
    let width = start.longitude - end.longitude;
    let height = start.latitude - end.latitude;
    let z = pow(sin(height / 2.0), 2) +
        cos(start.latitude) *
        cos(end.latitude) *
        pow(sin(width / 2.0), 2);
    let g = 2.0 * asin(sqrt(z));
    let delta = 1.0 / (Double(points) - 1.0);
    return (0...points).map { (step) in
        return interpolate(start, end: end, f: delta * Double(step), g: g);
    };
}