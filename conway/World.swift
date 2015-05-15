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
    
    var gridA: Grid
    var gridB: Grid
    
    var currentGrid: Grid   {
        return gridA.current ? gridA : gridB
    }
    
    var nextGrid: Grid   {
        return !gridA.current ? gridA : gridB
    }
    
    var iteration = 0
    
    init(gridWidth width: Int, gridHeight height: Int)   {
        gridA = Grid(gridWidth: width, gridHeight: height)
        gridB = Grid(gridWidth: width, gridHeight: height)
        gridA.makeCurrent()
    }
    
    func resizeGrid(newWidth width: Int, newHeight height: Int) {
        gridA = Grid(gridWidth: width, gridHeight: height)
        gridB = Grid(gridWidth: width, gridHeight: height)
    }
    
    func reset()   {
        gridA.reset()
        gridB.reset()
        gridA.makeCurrent()
        iteration = 0
    }
    
    func randomize(density: Int)    {
        currentGrid.randomize(density: density)
    }

    func process()    {
        
        // Change the grid according to the ruleset
        for (y, cellRow) in enumerate(currentGrid.cellGrid) {
            for (x, cell) in enumerate(cellRow) {
                let neighbors = currentGrid.checkNeighbors(atRow: y, andCol: x)
                if cell.isDead  {
                    if neighbors == 3 {
                        nextGrid.cellAtLocation(x: x, y: y).powerOn()
                    }
                    else    {
                        nextGrid.cellAtLocation(x: x, y: y).powerOff()
                    }
                }
                else    {
                    if neighbors < 2 || neighbors > 3 {
                        nextGrid.cellAtLocation(x: x, y: y).powerOff()
                    }
                    else    {
                        nextGrid.cellAtLocation(x: x, y: y).powerOn()
                    }
                }
            }
        }
        // Copy the changed grid to the original grid
        // currentGrid = nextGrid.duplicate()

        gridA.swapCurrent()
        gridB.swapCurrent()
        iteration++

    }

    func process2()    {
        
        nextGrid.reset()
        
        // Change the grid according to the ruleset
        for (y, cellRow) in enumerate(currentGrid.cellGrid) {
            for (x, cell) in enumerate(cellRow) {
                let neighbors = currentGrid.checkNeighbors(atRow: y, andCol: x)
                if neighbors == 3 || (cell.isAlive && neighbors == 2)   {
                    nextGrid.cellAtLocation(x: x, y: y).powerOn()
                }
            }
        }
        
        gridA.swapCurrent()
        gridB.swapCurrent()
        iteration++
        
    }
    
    func process3()    {
        
//        nextGrid.reset()
        
        // Change the grid according to the ruleset
//        for (y, cellRow) in enumerate(currentGrid.cellGrid) {
//            for (x, cell) in enumerate(cellRow) {
//                let neighbors = currentGrid.checkNeighbors(atRow: y, andCol: x)
//                if neighbors == 3 || (cell.isAlive && neighbors == 2)   {
//                    nextGrid.cellAtLocation(x: x, y: y).powerOn()
//                }
//            }
//        }
        
//        gridA.swapCurrent()
//        gridB.swapCurrent()
        iteration++
        
    }
    
}