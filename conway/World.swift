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
        println("Current BEFORE1:")
        currentGrid.printGrid()
        println("Next BEFORE:")
        nextGrid.printGrid()
        
        for (y, cellRow) in enumerate(currentGrid.cellGrid) {
            for (x, cell) in enumerate(cellRow) {
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
        
        println("Current BEFORE2:")
        currentGrid.printGrid()
        println("Next BEFORE2:")
        println("\(currentGrid.cellGrid[5].count)")
        nextGrid.printGrid()
//        currentGrid.cellGrid[5]
        
        currentGrid = nextGrid
        
//        for yy in 0..<currentGrid.gridHeight    {
//            for xx in 0..<currentGrid.gridWidth   {
//                currentGrid.cellGrid. = nextGrid.cellGrid[yy][xx]
//            }
//        }

        println("Current AFTER3:")
        currentGrid.printGrid()
        println("Next AFTER3:")
        nextGrid.printGrid()
        
    }

}