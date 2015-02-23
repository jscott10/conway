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
    
    var cellGrid: [[Cell]]
    
    init(width: Int, height: Int)   {
        boardWidth = width
        boardHeight = height
        
//        cellGrid = [[Cell]](count: boardHeight, repeatedValue: [Cell](count: boardWidth, repeatedValue: Cell()))
        cellGrid = [[Cell]]()

        println("\(cellGrid.count)")
        for h in 0..<boardHeight    {
            var c = [Cell]()
            for w in 0..<boardWidth  {
                c.append(Cell())
                println("h: \(h), w: \(w)")
            }
            cellGrid.append(c)
        }
    }
    
//    func location(i:Int) -> (x:Int, y:Int)   {
//        return (i % boardWidth, (i / boardWidth) % boardHeight)
        
        //        print("Cell at location [\(location!.x)],[\(location!.y)] :: ")
        //        location = CGPoint(x: i % boardWidth, y: (i / boardWidth) % boardHeight)

//    }
    
    func printWorld()   {
        for h in 0..<boardHeight    {
            for w in 0..<boardWidth   {
                if cellGrid[h][w].isDead    {
                    print(" ")
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
    
    func randomizeWorld(density: UInt32)   {
        for h in 0..<boardHeight    {
            for w in 0..<boardWidth   {
                randomizeCell(cellGrid[h][w], density: density)
            }
        }
    }
    
    func randomizeCell(cell: Cell, density: UInt32)   {
        var p:UInt32
        
        if density < 5  {
            p = 5
        }
        else if density > 100    {
            p = 100
        }
        else    {
            p = density
        }
        
        if arc4random_uniform(100) < p   {
            cell.powerOn()
        }
        else    {
            cell.powerOff()
        }
    }
    
    
    
}