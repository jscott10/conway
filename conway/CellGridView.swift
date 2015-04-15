//
//  CellGridView.swift
//  conway
//
//  Created by James Scott on 4/15/15.
//  Copyright (c) 2015 James Scott. All rights reserved.
//

import UIKit

class CellGridView: UIView {

    func displayGrid(grid: Grid, cellSize: Int)  {
        
        // Cells plus borders
        //        let imageWidth = grid.gridWidth * (cellSize + 1) + 3
        //        let imageHeight = grid.gridHeight * (cellSize + 1) + 3
        //        let imageWidth = self.view.frame.size.width
        //        let imageHeight = self.view.frame.size.width
        let imageWidth = 602
        let imageHeight = 602
        
        let cellSpacing:Int = 1
        
        let imageSize = CGSize(width: imageWidth, height: imageHeight)
        
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 50, y: 50), size: imageSize))
        self.view.addSubview(imageView)
        
        // Setup our context
        let opaque = true
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, opaque, scale)
        
        let context = UIGraphicsGetCurrentContext()
        
        //        drawBoxGrid(context, grid: grid, cellSide: cellSize)
        let cellSize = CGSize(width: cellSize, height: cellSize)
        
        // Setup complete, do drawing here
        CGContextSetFillColorWithColor(context, UIColor.brownColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        
        for (y, cellRow) in enumerate(grid.cellGrid) {
            for (x, cell) in enumerate(cellRow) {
                let xOffset = x * (Int(cellSize.width) + cellSpacing)
                let yOffset = y * (Int(cellSize.height) + cellSpacing)
                //                let xOffset = 2 + (x * (cellSide + cellSpacing))
                //                let yOffset = 2 + (y * (cellSide + cellSpacing))
                if cell.isAlive {
                    CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
                }
                else    {
                    CGContextSetFillColorWithColor(context, UIColor.brownColor().CGColor)
                }
                CGContextFillRect(context, CGRect(origin: CGPoint(x: xOffset, y: yOffset), size: cellSize))
            }
        }
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageView.image = image
        
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 1.0)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
        
    }

}
