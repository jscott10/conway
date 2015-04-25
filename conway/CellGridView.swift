//
//  CellGridView.swift
//  conway
//
//  Created by James Scott on 4/15/15.
//  Copyright (c) 2015 James Scott. All rights reserved.
//

import UIKit

class CellGridView: UIView {
    
    var world:World!
    
    func displayGrid()  {
        
        let grid = world.currentGrid
//        let cellSize = world.cellSize
        let cellSize:Float = Float(Float(CGRectGetWidth(self.bounds)) + Float(grid.gridWidth) - 1.0) / Float(grid.gridWidth)

        // Cells plus borders
        //        let imageWidth = grid.gridWidth * (cellSize + 1) + 3
        //        let imageHeight = grid.gridHeight * (cellSize + 1) + 3
        
        let viewWidth = CGRectGetWidth(self.bounds)
        let viewHeight = CGRectGetHeight(self.bounds)
        println("viewWidth: \(viewWidth)")
        println("viewHeight: \(viewHeight)")
        
        
        let cellSpacing:Float = 1.0
        
        // Setup our context
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, CGFloat(cellSpacing))
        
        // Cell Border color
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        for (y, cellRow) in enumerate(grid.cellGrid) {
            let yOffset = Float(y) * (cellSize - cellSpacing)
            for (x, cell) in enumerate(cellRow) {
                let xOffset = Float(x) * (cellSize - cellSpacing)
                let currentRect = CGRectMake(CGFloat(xOffset), CGFloat(yOffset), CGFloat(cellSize), CGFloat(cellSize))
                if cell.isAlive {
                    CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
                }
                else    {
                    CGContextSetFillColorWithColor(context, UIColor.brownColor().CGColor)
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
        displayGrid()
    }

}
