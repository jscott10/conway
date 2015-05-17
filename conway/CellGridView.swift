//
//  CellGridView.swift
//  conway
//
//  Created by James Scott on 4/15/15.
//  Copyright (c) 2015 James Scott. All rights reserved.
//

import UIKit

class CellGridView: UIView {
    
    var grid:Grid!
    
    func displayCellsWithGrid()  {
        
        //        let cellSize:Float = Float(Float(CGRectGetWidth(self.bounds)) + Float(grid.gridWidth) - 1.0) / Float(grid.gridWidth)
        //        let cellSize = CGFloat(ceil(bounds.width / CGFloat(grid.gridWidth)))
        
        // Size of cell including border, small enough to fit in the view without scaling
        //        let cellSize = floor((bounds.width + CGFloat(grid.gridWidth) - 1.0) / CGFloat(grid.gridWidth))
        let cellSize = (bounds.width + CGFloat(grid.gridWidth) - 1.0) / CGFloat(grid.gridWidth)
        
        // the margin required to center the board in the view
        //        let margin = floor((bounds.width - (cellSize - 1.0) * CGFloat(grid.gridWidth)) / 2.0)
        let margin = (bounds.width - (cellSize - 1.0) * CGFloat(grid.gridWidth)) / 2.0
        
        let cellSpacing:CGFloat = 0.5
        
        let cellOffset:CGFloat = cellSize - cellSpacing
        
        /*
        println("xxxxxxxx")
        println("bounds.width: \(bounds.width)")
        println("cellSize: \(cellSize)")
        println("margin: \(margin)")
        println("cellSpacing: \(cellSpacing)")
        println("cellOffset: \(cellOffset)")
        */
        
        // Setup our context
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, CGFloat(cellSpacing))
        
        // Cell Border color
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        for (y, cellRow) in enumerate(grid.cellGrid) {
            //            let yOffset = CGFloat(y) * cellOffset + margin
            let yOffset = CGFloat(y) * cellOffset
            for (x, cell) in enumerate(cellRow) {
                //                let xOffset = CGFloat(x) * cellOffset + margin
                let xOffset = CGFloat(x) * cellOffset
                var currentRect =  CGRectOffset(CGRectMake(0, 0, cellSize, cellSize), xOffset, yOffset)
                if cell.isAlive {
                    CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
                }
                else    {
                    if x == grid.gridWidth-1  {
                        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
                        if y == grid.gridHeight-1    {
                            println("++++ corner size is: \(currentRect.size.width) by \(currentRect.size.height)")
                        }
                    }
                    else    {
                        CGContextSetFillColorWithColor(context, UIColor.brownColor().CGColor)
                    }
                }
                CGContextAddRect(context, currentRect)
                CGContextDrawPath(context, kCGPathEOFillStroke)
            }
        }
    }
    
    func displayCellsWithoutGrid(width: Int, height: Int)  {
        
        let cellSize:CGFloat = round(bounds.width / CGFloat(width))
        let cellOffset:CGFloat = cellSize
        
        // Setup our context
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, 0)
        
        // Cell Border color
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        for (y, cellRow) in enumerate(grid.cellGrid) {
            let yOffset = CGFloat(y) * cellOffset
            for (x, cell) in enumerate(cellRow) {
                let xOffset = CGFloat(x) * cellOffset
                var currentRect =  CGRectOffset(CGRectMake(0, 0, cellSize, cellSize), xOffset, yOffset)
                if cell.isAlive {
                    CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
                }
                else    {
                    if x == width-1  {
                        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
                        if y == height-1    {
                            println("++++ corner size is: \(currentRect.size.width) by \(currentRect.size.height)")
                        }
                    }
                    else    {
                        CGContextSetFillColorWithColor(context, UIColor.brownColor().CGColor)
                    }
                }
                CGContextAddRect(context, currentRect)
                CGContextDrawPath(context, kCGPathEOFillStroke)
            }
        }
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        displayCellsWithoutGrid(grid.gridWidth, height: grid.gridHeight)
    }

}
