//
//  Grid.swift
//  conway
//
//  Created by James Scott on 2/24/15.
//  Copyright (c) 2015 James Scott. All rights reserved.
//

import Foundation

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
    
    func randomize(density:Int)   {
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
    
    func checkNeighbors(atRow y: Int, andCol x: Int) -> Int     {
        
        var neighbors:Int = 0
        
        let plusY = (y + gridHeight + 1) % gridHeight
        let minusY = (y + gridHeight - 1) % gridHeight
        let plusX = (x + gridWidth + 1) % gridWidth
        let minusX = (x + gridWidth - 1) % gridWidth
        
        print("\(x), \(y) : ")

        if cellGrid[minusY][minusX].isAlive    {
            neighbors++
            print("Y")
        } else {print("N")}
        if cellGrid[minusY][x].isAlive    {
            neighbors++
            print("Y")
        } else {print("N")}
        if cellGrid[minusY][plusX].isAlive    {
            neighbors++
            print("Y ")
        } else {print("N ")}
        if cellGrid[y][minusX].isAlive    {
            neighbors++
            print("Y")
        } else {print("N")}
        if cellGrid[y][plusX].isAlive    {
            neighbors++
            print("Y ")
        } else {print("N ")}
        if cellGrid[plusY][minusX].isAlive    {
            neighbors++
            print("Y")
        } else {print("N")}
        if cellGrid[plusY][x].isAlive    {
            neighbors++
            print("Y")
        } else {print("N")}
        if cellGrid[plusY][plusX].isAlive    {
            neighbors++
            print("Y")
        } else {print("N")}
        
        print(" : -Y=\(minusY), +Y=\(plusY), -X=\(minusX), +X=\(plusX) : n=\(neighbors)")
        println()
        
        return neighbors
        
    }
    
    func printGrid()   {
        for xx in 0..<gridWidth+1   {
            print("--")
        }
        println()
        for y in 0..<gridHeight    {
            print("| ")
            for x in 0..<gridWidth   {
                if cellGrid[y][x].isDead    {
                    print(" ")
                }
                else    {
                    print("O")
                }
                print(" ")
            }
            println("|")
        }
        for xx in 0..<gridWidth+1   {
            print("--")
        }
        println()
    }

}