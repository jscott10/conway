//
//  Cell.swift
//  conway
//
//  This is a single Cell, that lives on a grid square
//
//  Cell has an energyLevel
//  Cell isAlive if energyLevel > 0
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
    
    func printState()   {
        if isDead    {
            println("Cell is Dead.")
        }
        else    {
            println("Energy Level = \(energyLevel).")
        }
    }
}