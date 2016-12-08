//
//  Contents.swift
//  AdventOfCode2016
//
//  Created by Carl J Nash on 08/12/2016.
//  Copyright © 2016 CJN. All rights reserved.
//

import Foundation

// Advent of Code 2016
// Day 1

let instructionsString = "L2, L5, L5, R5, L2, L4, R1, R1, L4, R2, R1, L1, L4, R1, L4, L4, R5, R3, R1, L1, R1, L5, L1, R5, L4, R2, L5, L3, L3, R3, L3, R4, R4, L2, L5, R1, R2, L2, L1, R3, R4, L193, R3, L5, R45, L1, R4, R79, L5, L5, R5, R1, L4, R3, R3, L4, R185, L5, L3, L1, R5, L2, R1, R3, R2, L3, L4, L2, R2, L3, L2, L2, L3, L5, R3, R4, L5, R1, R2, L2, R4, R3, L4, L3, L1, R3, R2, R1, R1, L3, R4, L5, R2, R1, R3, L3, L2, L2, R2, R1, R2, R3, L3, L3, R4, L4, R4, R4, R4, L3, L1, L2, R5, R2, R2, R2, L4, L3, L4, R4, L5, L4, R2, L4, L4, R4, R1, R5, L2, L4, L5, L3, L2, L4, L4, R3, L3, L4, R1, L2, R3, L2, R1, R2, R5, L4, L2, L1, L3, R2, R3, L2, L1, L5, L2, L1, R4"

let instructionsArray = instructionsString.componentsSeparatedByString(", ")

let startX = 0
let startY = 0

var endX = startX
var endY = startY

enum CompassDirection {
    case north, south, east, west
}

enum Operand {
    case add, subtract, none
}

enum Axis {
    case x, y
}

var currentCompassDirection = CompassDirection.north
var addOrSubtract = Operand.none
var currentAxis = Axis.x

for instruction in instructionsArray {
    if instruction.characters.count < 2 { continue }
    let index = instruction.startIndex.advancedBy(1)
    let wayToTurn = instruction.substringToIndex(index)
    let distanceString = instruction.substringFromIndex(index)
    guard let distanceInt = Int(distanceString)
        else { continue }
    
    switch currentCompassDirection {
    case .north:
        if wayToTurn == "L" {
            currentCompassDirection = .west
            addOrSubtract = .subtract
        } else if wayToTurn == "R" {
            currentCompassDirection = .east
            addOrSubtract = .add
        }
    case .south:
        if wayToTurn == "L" {
            currentCompassDirection = .east
            addOrSubtract = .add
        } else if wayToTurn == "R" {
            currentCompassDirection = .west
            addOrSubtract = .subtract
        }
    case .east:
        if wayToTurn == "L" {
            currentCompassDirection = .north
            addOrSubtract = .add
        } else if wayToTurn == "R" {
            currentCompassDirection = .south
            addOrSubtract = .subtract
        }
    case .west:
        if wayToTurn == "L" {
            currentCompassDirection = .south
            addOrSubtract = .subtract
        } else if wayToTurn == "R" {
            currentCompassDirection = .north
            addOrSubtract = .add
        }
    }
    
    if currentAxis == .x {
        if addOrSubtract == .add {
            endX += distanceInt
        } else {
            endX -= distanceInt
        }
    } else {
        if addOrSubtract == .add {
            endY += distanceInt
        } else {
            endY -= distanceInt
        }
    }
    
    currentAxis = currentAxis == .x ? .y : .x
}

print("End point coordinates: x=\(endX), y=\(endY)")

// Dt (A, B) = Taxicab Distance =  (|x1 - x2|  + |y1 – y2|
let taxiCabDistance = abs(startX - endX) + abs(startY - endY)

print("The taxicab distance back to the start is \(taxiCabDistance)")
