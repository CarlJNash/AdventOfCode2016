//
//  Contents.swift
//  AdventOfCode2016
//
//  Created by Carl J Nash on 08/12/2016.
//  Copyright © 2016 CJN. All rights reserved.
//

import Foundation
import CoreLocation

// Advent of Code 2016
// Day 1

let instructionsString = "L5, R1, R4, L5, L4, R3, R1, L1, R4, R5, L1, L3, R4, L2, L4, R2, L4, L1, R3, R1, R1, L1, R1, L5, R5, R2, L5, R2, R1, L2, L4, L4, R191, R2, R5, R1, L1, L2, R5, L2, L3, R4, L1, L1, R1, R50, L1, R1, R76, R5, R4, R2, L5, L3, L5, R2, R1, L1, R2, L3, R4, R2, L1, L1, R4, L1, L1, R185, R1, L5, L4, L5, L3, R2, R3, R1, L5, R1, L3, L2, L2, R5, L1, L1, L3, R1, R4, L2, L1, L1, L3, L4, R5, L2, R3, R5, R1, L4, R5, L3, R3, R3, R1, R1, R5, R2, L2, R5, L5, L4, R4, R3, R5, R1, L3, R1, L2, L2, R3, R4, L1, R4, L1, R4, R3, L1, L4, L1, L5, L2, R2, L1, R1, L5, L3, R4, L1, R5, L5, L5, L1, L3, R1, R5, L2, L4, L5, L1, L1, L2, R5, R5, L4, R3, L2, L1, L3, L4, L5, L5, L2, R4, R3, L5, R4, R2, R1, L5"

let instructionsArray = instructionsString.componentsSeparatedByString(", ")

enum CompassDirection:CLLocationDirection {
    case north = 0, east = 90, south = 180, west = 270
}

class MyLocation: CLLocation {
    var currentCourse = CompassDirection.north
    var currentCoordinate = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
}

// This is our starting point
var myLocation = MyLocation.init(coordinate: CLLocationCoordinate2D.init(latitude: 0, longitude: 0),
                                 altitude: 0,
                                 horizontalAccuracy: 0,
                                 verticalAccuracy: 0,
                                 course: CLLocationDirection.init(),
                                 speed: 0,
                                 timestamp: NSDate.init());

var stops = [myLocation.currentCoordinate]

for instruction in instructionsArray {
    if instruction.characters.count < 2 { continue }
    let index = instruction.startIndex.advancedBy(1)
    let wayToTurn = instruction.substringToIndex(index)
    let distanceString = instruction.substringFromIndex(index)
    guard let distance = Double(distanceString)
        else { continue }
    
    switch myLocation.currentCourse {
    case .north:
        if wayToTurn == "L" {
            myLocation.currentCourse = .west
            myLocation.currentCoordinate.longitude -= distance
        } else if wayToTurn == "R" {
            myLocation.currentCourse = .east
            myLocation.currentCoordinate.longitude += distance
        }
    case .south:
        if wayToTurn == "L" {
            myLocation.currentCourse = .east
            myLocation.currentCoordinate.latitude += distance
        } else if wayToTurn == "R" {
            myLocation.currentCourse = .west
            myLocation.currentCoordinate.latitude -= distance
        }
    case .east:
        if wayToTurn == "L" {
            myLocation.currentCourse = .north
            myLocation.currentCoordinate.longitude += distance
        } else if wayToTurn == "R" {
            myLocation.currentCourse = .south
            myLocation.currentCoordinate.longitude -= distance
        }
    case .west:
        if wayToTurn == "L" {
            myLocation.currentCourse = .south
            myLocation.currentCoordinate.latitude -= distance
        } else if wayToTurn == "R" {
            myLocation.currentCourse = .north
            myLocation.currentCoordinate.latitude += distance
        }
    }
    
    // Add our current coordinates to the array of stops that we make
    stops.append(myLocation.currentCoordinate)
}

print("End point coordinates: lat=\(myLocation.currentCoordinate.latitude), long=\(myLocation.currentCoordinate.longitude)")

// Dt (A, B) = Taxicab Distance =  (|x1 - x2|  + |y1 – y2|
let taxiCabDistance = abs(0.0 - myLocation.currentCoordinate.longitude) + abs(0.0 - myLocation.currentCoordinate.latitude)

print("The taxicab distance back to the start is \(taxiCabDistance)")
