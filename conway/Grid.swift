//
//  Grid.swift
//  conway
//
//  This class represents a single grid of squares that contain Cell objects
//  Its only purpose is to organize cells into a grid
//
//  Each square contains a Cell
//  Each Cell changes based on neighboring Cells
//
//  Created by James Scott on 2/24/15.
//  Copyright (c) 2015 James Scott. All rights reserved.
//

import Foundation

class Grid  {
    
    let gridWidth: Int      // Number of cells across
    let gridHeight: Int     // Number of cells down
    
    var cellGrid = [[Cell]]()
    
    init(gridWidth:Int, gridHeight:Int)   {
        
        self.gridWidth = gridWidth
        self.gridHeight = gridHeight
        
        // Build the grid of Cell objects
        for y in 0..<gridHeight    {
            var c = [Cell]()
            for x in 0..<gridWidth  {
                c.append(Cell())
            }
            cellGrid.append(c)
        }
    }
    
    // this can go into a convenience initializer
    func randomize(#density: Int)   {
        for cellRow in cellGrid {
            for cell in cellRow {
                if Int(arc4random_uniform(100)) < density   {
                    cell.powerOn()
                }
                else    {
                    cell.powerOff()
                }
            }
        }
    }
    
    // Duplicate this Grid
    func duplicate() -> Grid    {
        let dupGrid:Grid = Grid(gridWidth: gridWidth, gridHeight: gridHeight)
        // Copy the changed grid to the original grid
        for (y, cellRow) in enumerate(cellGrid) {
            for (x, cell) in enumerate(cellRow) {
                dupGrid.cellGrid[y][x].energyLevel = cell.energyLevel
            }
        }
        return dupGrid
    }
    
    func placeGlider(y: Int, x: Int)  {
        cellGrid[y][x].powerOn()
        cellGrid[y+1][x+1].powerOn()
        cellGrid[y+1][x+2].powerOn()
        cellGrid[y+2][x].powerOn()
        cellGrid[y+2][x+1].powerOn()
    }
    
    func setupPulsar()   {
        
        // Rows
        cellGrid[2][4].powerOn()
        cellGrid[2][5].powerOn()
        cellGrid[2][6].powerOn()
        cellGrid[2][10].powerOn()
        cellGrid[2][11].powerOn()
        cellGrid[2][12].powerOn()
        
        cellGrid[7][4].powerOn()
        cellGrid[7][5].powerOn()
        cellGrid[7][6].powerOn()
        cellGrid[7][10].powerOn()
        cellGrid[7][11].powerOn()
        cellGrid[7][12].powerOn()
        
        cellGrid[9][4].powerOn()
        cellGrid[9][5].powerOn()
        cellGrid[9][6].powerOn()
        cellGrid[9][10].powerOn()
        cellGrid[9][11].powerOn()
        cellGrid[9][12].powerOn()
        
        cellGrid[14][4].powerOn()
        cellGrid[14][5].powerOn()
        cellGrid[14][6].powerOn()
        cellGrid[14][10].powerOn()
        cellGrid[14][11].powerOn()
        cellGrid[14][12].powerOn()
        
        // Cols
        cellGrid[4][2].powerOn()
        cellGrid[5][2].powerOn()
        cellGrid[6][2].powerOn()
        cellGrid[10][2].powerOn()
        cellGrid[11][2].powerOn()
        cellGrid[12][2].powerOn()
        
        cellGrid[4][7].powerOn()
        cellGrid[5][7].powerOn()
        cellGrid[6][7].powerOn()
        cellGrid[10][7].powerOn()
        cellGrid[11][7].powerOn()
        cellGrid[12][7].powerOn()
        
        cellGrid[4][9].powerOn()
        cellGrid[5][9].powerOn()
        cellGrid[6][9].powerOn()
        cellGrid[10][9].powerOn()
        cellGrid[11][9].powerOn()
        cellGrid[12][9].powerOn()
        
        cellGrid[4][14].powerOn()
        cellGrid[5][14].powerOn()
        cellGrid[6][14].powerOn()
        cellGrid[10][14].powerOn()
        cellGrid[11][14].powerOn()
        cellGrid[12][14].powerOn()
    }
    
    // Return number of LIVE neighboring cells -- basic GoL
    
    func checkNeighbors(atRow y: Int, andCol x: Int) -> Int     {
        
        var neighbors:Int = 0
        
        let plusY = (y + cellGrid.count + 1) % cellGrid.count
        let minusY = (y + cellGrid.count - 1) % cellGrid.count
        let plusX = (x + cellGrid[0].count + 1) % cellGrid[0].count
        let minusX = (x + cellGrid[0].count - 1) % cellGrid[0].count
        
        if cellGrid[minusY][minusX].isAlive    {
            neighbors++
        }
        if cellGrid[minusY][x].isAlive    {
            neighbors++
        }
        if cellGrid[minusY][plusX].isAlive    {
            neighbors++
        }
        if cellGrid[y][minusX].isAlive    {
            neighbors++
        }
        if cellGrid[y][plusX].isAlive    {
            neighbors++
        }
        if cellGrid[plusY][minusX].isAlive    {
            neighbors++
        }
        if cellGrid[plusY][x].isAlive    {
            neighbors++
        }
        if cellGrid[plusY][plusX].isAlive    {
            neighbors++
        }
        
        return neighbors
        
    }
    
    func printGrid()   {
        print(":")
        for x in 0..<(cellGrid[0].count+1)*2-1   {
            print("-")
        }
        println(":")
        for (y, cellRow) in enumerate(cellGrid)    {
            print("| ")
            for (x, cell) in enumerate(cellRow)   {
                if cell.isDead    {
                    print("- ")
                }
                else    {
                    print("O ")
                }
            }
            println("|")
        }
        print(":")
        for x in 0..<(cellGrid[0].count+1)*2-1   {
            print("-")
        }
        println(":")
    }

}