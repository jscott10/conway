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
    
    let boardWidth: Int
    let boardHeight: Int
    
    var currentGrid: [[Cell]]
    var nextGrid: [[Cell]]
    
    init(width: Int, height: Int)   {
        boardWidth = width
        boardHeight = height
        
//        cellGrid = [[Cell]](count: boardHeight, repeatedValue: [Cell](count: boardWidth, repeatedValue: Cell()))
        currentGrid = [[Cell]]()
        
        for h in 0..<boardHeight    {
            var c = [Cell]()
            for w in 0..<boardWidth  {
                c.append(Cell())
            }
            currentGrid.append(c)
        }
        
        nextGrid = currentGrid
    }
    
//    func location(i:Int) -> (x:Int, y:Int)   {
//        return (i % boardWidth, (i / boardWidth) % boardHeight)
        
        //        print("Cell at location [\(location!.x)],[\(location!.y)] :: ")
        //        location = CGPoint(x: i % boardWidth, y: (i / boardWidth) % boardHeight)

//    }
    
    func printWorld()   {
        for h in 0..<boardHeight    {
            for w in 0..<boardWidth   {
                if nextGrid[h][w].isDead    {
                    print("-")
                }
                else    {
                    print("O")
                }
                print(" ")
            }
            println()
        }
        println()
    }
    
    func randomizeWorld(density:Int)   {
        for h in 0..<boardHeight    {
            for w in 0..<boardWidth   {
                randomizeCell(currentGrid[h][w], density: density)
            }
        }
    }
    
    func processWorld()     {
        for h in 0..<boardHeight    {
            for w in 0..<boardWidth   {
                if currentGrid[h][w].isDead {
                    if checkNeighbors(atLocationX: w, andY: h) == 3 {
                        nextGrid[h][w].powerOn()
                    }
                }
                else    {
                    if checkNeighbors(atLocationX: w, andY: h) == 2 || checkNeighbors(atLocationX: w, andY: h) == 3 {
                        nextGrid[h][w].powerOn()
                    }
                    else    {
                        nextGrid[h][w].kill()
                    }
                }
            }
        }
        currentGrid = nextGrid
    }
    
    func checkNeighbors(atLocationX x: Int, andY y: Int) -> Int     {
        
        var neighbors:Int = 0

        let plusX = (x + boardWidth + 1) % boardWidth
        let minusX = (x + boardWidth - 1) % boardWidth
        let plusY = (y + boardHeight + 1) % boardHeight
        let minusY = (y + boardHeight - 1) % boardHeight
        
        if currentGrid[minusY][minusX].isAlive    {
            neighbors++
        }
        if currentGrid[minusY][x].isAlive    {
            neighbors++
        }
        if currentGrid[minusY][plusX].isAlive    {
            neighbors++
        }
        if currentGrid[y][minusX].isAlive    {
            neighbors++
        }
        if currentGrid[y][plusX].isAlive    {
            neighbors++
        }
        if currentGrid[plusY][minusX].isAlive    {
            neighbors++
        }
        if currentGrid[plusY][x].isAlive    {
            neighbors++
        }
        if currentGrid[plusY][plusX].isAlive    {
            neighbors++
        }
        
        return neighbors
        
    }
    
    func randomizeCell(cell: Cell, density: Int)   {
        var p:Int
        
        if density < 5  {
            p = 5
        }
        else if density > 100    {
            p = 100
        }
        else    {
            p = density
        }
        
        if Int(arc4random_uniform(100)) < p   {
            cell.powerOn()
        }
        else    {
            cell.powerOff()
        }
    }
    
    
    
}