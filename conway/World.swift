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
    
    var cellGrid = [Cell]()
    
    init(width: Int, height: Int)   {
        boardWidth = width
        boardHeight = height
        
        for index in 0...(width*height) {
            cellGrid.append(Cell())
        }
    }
    
    func location(i:Int) -> (x:Int, y:Int)   {
        return (i % boardWidth, (i / boardWidth) % boardHeight)
        
        //        print("Cell at location [\(location!.x)],[\(location!.y)] :: ")
        //        location = CGPoint(x: i % boardWidth, y: (i / boardWidth) % boardHeight)

    }
    
    func printWorld()   {
        for index in 0..<(boardWidth*boardHeight)   {
            if cellGrid[index].isDead    {
                print("O")
            }
            else    {
                print("X")
            }
            if location(index).x == boardWidth-1    {
                println()
            }
            else {
                print(" ")
            }
        }
    }
    
    func liveCell() -> Cell {
        var cell = Cell()
        cell.powerOn()
        return cell
    }
    
    func deadCell() -> Cell {
        return Cell()
    }
    
    func randomCell() -> Cell   {
        if arc4random_uniform(2) == 0   {
            return deadCell()
        }
        else    {
            return liveCell()
        }
    }
    
    
    
}