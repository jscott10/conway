//
//  Grid.swift
//  conway
//
//  Created by James Scott on 2/24/15.
//  Copyright (c) 2015 James Scott. All rights reserved.
//

import Foundation
import UIKit

class Grid  {
    
    var cellGrid = [[Cell]]()
    let gridWidth: Int
    let gridHeight: Int
    
    init(gridWidth width: Int, gridHeight height: Int)   {
        
        gridWidth = width
        gridHeight = height
        
        for y in 0..<height    {
            var c = [Cell]()
            for x in 0..<width  {
                c.append(Cell())
            }
            cellGrid.append(c)
        }
    }

    /*
    func copy() -> Grid {
        for (y, cellRow) in enumerate(cellGrid) {
            for (x, cell) in enumerate(cellRow) {
        for y in 0..<gridHeight    {
            c = copy.()
            for x in 0..<gridWidth  {
                c.append(Cell())
            }
            cellGrid.append(c)
        }
    }
*/
    
    func randomize(density: Int)   {
        for (y, cellRow) in enumerate(cellGrid) {
            for (x, cell) in enumerate(cellRow) {
                if Int(arc4random_uniform(100)) < density   {
                    cell.powerOn()
                }
                else    {
                    cell.powerOff()
                }
            }
        }
    }
    
    func randomize2(density:Int)   {
        for y in 0..<gridHeight    {
            for x in 0..<gridWidth   {
                if Int(arc4random_uniform(100)) < density   {
                    cellGrid[y][x].powerOn()
                }
                else    {
                    cellGrid[y][x].powerOff()
                }
            }
        }
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
    
    func checkNeighbors(atRow y: Int, andCol x: Int) -> Int     {
        
        var neighbors:Int = 0
        
        let plusY = (y + gridHeight + 1) % gridHeight
        let minusY = (y + gridHeight - 1) % gridHeight
        let plusX = (x + gridWidth + 1) % gridWidth
        let minusX = (x + gridWidth - 1) % gridWidth
        
//        print("\(x), \(y) : ")

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
        
 //       print(" : -Y=\(minusY), +Y=\(plusY), -X=\(minusX), +X=\(plusX) : n=\(neighbors)")
 //       println()
        
        return neighbors
        
    }
    
    func printGrid()   {
        print(":")
        for x in 0..<(gridWidth+1)*2-1   {
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
        for x in 0..<(gridWidth+1)*2-1   {
            print("-")
        }
        println(":")
    }

}