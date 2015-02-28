//
//  World.swift
//  conway
//
//  Created by James Scott on 2/16/15.
//  Copyright (c) 2015 James Scott. All rights reserved.
//

import Foundation
import UIKit

class World  {
    
    var currentGrid:Grid
    var nextGrid:Grid
    
    init(gridWidth width: Int, gridHeight height: Int)   {
        
        currentGrid = Grid(gridWidth: width, gridHeight: height)
        nextGrid = Grid(gridWidth: width, gridHeight: height)
        
    }

    func processWorld()     {
        
        // Change the grid according to the ruleset
        for (y, cellRow) in enumerate(currentGrid.cellGrid) {
            for (x, cell) in enumerate(cellRow) {
                let neighbors = currentGrid.checkNeighbors(atRow: y, andCol: x)
                if cell.isDead {
                    if neighbors == 3 {
                        nextGrid.cellGrid[y][x].powerOn()
                    }
                    else    {
                        nextGrid.cellGrid[y][x].powerOff()
                    }
                }
                else    {
                    if neighbors == 2 || neighbors == 3 {
                        nextGrid.cellGrid[y][x].powerOn()
                    }
                    else    {
                        nextGrid.cellGrid[y][x].powerOff()
                    }
                }
            }
        }
        
        // Copy the changed grid to the original grid
        for (y, cellRow) in enumerate(nextGrid.cellGrid) {
            for (x, cell) in enumerate(cellRow) {
                currentGrid.cellGrid[y][x].energyLevel = cell.energyLevel
            }
        }

    }

}