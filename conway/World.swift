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
        for y in 0..<currentGrid.gridHeight    {
            for x in 0..<currentGrid.gridWidth   {
                let neighbors = currentGrid.checkNeighbors(atRow: y, andCol: x)
                if currentGrid.cellGrid[y][x].isDead {
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
        
        println("Current BEFORE:")
        currentGrid.printGrid()
        println("Next BEFORE:")
        nextGrid.printGrid()
        
        currentGrid = nextGrid

        println("Current AFTER:")
        currentGrid.printGrid()
        println("Next AFTER:")
        nextGrid.printGrid()
        
    }

}