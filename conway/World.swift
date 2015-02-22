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
    
    let boardWidth = 5
    let boardHeight = 8
    
    var cellGrid = [Cell]()
    
    func populateEmpty()  {
        for var i in boardWidth * boardHeight - 1
    }
    
    func coords(i:Int)    {
        let x = i % boardWidth
        let y = i % boardHeight
        
        //        print("Cell at location [\(location!.x)],[\(location!.y)] :: ")
        
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