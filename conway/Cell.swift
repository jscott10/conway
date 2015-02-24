//
//  Cell.swift
//  conway
//
//  Created by James Scott on 12/2/14.
//  Copyright (c) 2014 James Scott. All rights reserved.
//

import Foundation
import UIKit

class Cell  {
    
    var energyLevel = 0
    
    var isDead: Bool { return energyLevel == 0 }
    
    var isAlive: Bool { return energyLevel == 1 }
    
    //    let location: CGPoint?
    
    //    init(atIndex i: Int)    {
    //        location = CGPoint(x: i % boardWidth, y: (i / boardWidth) % boardHeight)
    //    }
    
    func powerUp()  {
        energyLevel++
    }
    
    func powerDown()  {
        energyLevel--
    }
    
    func powerOn()  {
        energyLevel = 1
    }
    
    func powerOff()  {
        energyLevel = 0
    }
    
    func kill() {
        energyLevel = 0
    }
    
    func printState()   {
        if isDead    {
            println("Cell is Dead.")
        }
        else    {
            println("Energy Level = \(energyLevel).")
        }
    }
}