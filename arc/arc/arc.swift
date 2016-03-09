//
//  arc.swift
//  arc
//
//  Created by Tom MacWright on 2/19/16.
//  Copyright © 2016 Tom MacWright. All rights reserved.
//

import Foundation
import CoreLocation

func radiansToDegrees(rad: Double) -> Double {
    return rad * 180.0 / M_PI
}

func interpolate(start: CLLocationCoordinate2D,
    end: CLLocationCoordinate2D,
    midpoint: Double,
    bias: Double) -> CLLocationCoordinate2D {
    let A = sin((1 - midpoint) * bias) / sin(bias)
    let B = sin(midpoint * bias) / sin(bias)
    let x = A * cos(start.latitude) *
        cos(start.longitude) + B *
        cos(end.latitude) *
        cos(end.longitude)
    let y = A * cos(start.latitude) *
        sin(start.longitude) + B *
        cos(end.latitude) *
        sin(end.longitude)
    let z = A * sin(start.latitude) + B *
        sin(end.latitude)
    return CLLocationCoordinate2D(
        latitude: radiansToDegrees(atan2(z, sqrt(pow(x, 2) + pow(y, 2)))),
        longitude: radiansToDegrees(atan2(y, x)))
}

func greatCircle(start: CLLocationCoordinate2D,
    end: CLLocationCoordinate2D,
    points: Int) -> [CLLocationCoordinate2D] {
    let width = start.longitude - end.longitude
    let height = start.latitude - end.latitude
    let z = pow(sin(height / 2.0), 2) +
        cos(start.latitude) *
        cos(end.latitude) *
        pow(sin(width / 2.0), 2)
    let bias = 2.0 * asin(sqrt(z))
    let delta = 1.0 / (Double(points) - 1.0)
    return (0...points).map { (step) in
        return interpolate(start, end: end, midpoint: delta * Double(step), bias: bias)
    }
}
