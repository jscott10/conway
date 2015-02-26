//
//  ViewController.swift
//  conway
//
//  Created by James Scott on 12/2/14.
//  Copyright (c) 2014 James Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let w = World(gridWidth: 14, gridHeight: 24)
    
    var density = 55
    
    @IBAction func densitySlider(sender: UISlider) {
        density = lroundf(sender.value)
        densityValue.text = "\(density)"
        w.currentGrid.randomize(density)
        w.currentGrid.printGrid()
        
    }
    
    @IBOutlet weak var densityValue: UILabel!
    
    @IBAction func updateGrid() {
        
    w.processWorld()
    w.currentGrid.printGrid()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        w.currentGrid.randomize(density)
//        w.currentGrid.printGrid()
        
        //       let imageSize = CGSize(width: 200, height: 200)
        //      let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 100, y: 100), size: imageSize))
        //       self.view.addSubview(imageView)
        //      let image = drawCustomImage(imageSize)
        //       imageView.image = image
    }
    
    func drawBoxGrid(context: CGContext, numAcross: Int, numDown: Int, cellSide: Int)  {
        
        let cellSpacing = 1
        
        var cellSize = CGSize(width: cellSide, height: cellSide)
        
        // Setup complete, do drawing here
        CGContextSetFillColorWithColor(context, UIColor.brownColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        
        for xx in 0..<numAcross {
            for yy in 0..<numDown {
                let xOffset = 2 + (xx * (cellSide + cellSpacing))
                let yOffset = 2 + (yy * (cellSide + cellSpacing))
                CGContextFillRect(context, CGRect(origin: CGPoint(x: xOffset, y: yOffset), size: cellSize))
            }
        }
    }
    
    func drawCustomImage(size: CGSize) -> UIImage {
        // Setup our context
        let bounds = CGRect(origin: CGPoint.zeroPoint, size: size)
        let opaque = true
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        drawBoxGrid(context, numAcross: 33, numDown: 33, cellSide: 5)
        
        /*
        
        CGContextSetLineWidth(context, 2.0)
        
        CGContextStrokeRect(context, bounds)
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, CGRectGetMinX(bounds), CGRectGetMinY(bounds))
        CGContextAddLineToPoint(context, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))
        CGContextMoveToPoint(context, CGRectGetMaxX(bounds), CGRectGetMinY(bounds))
        CGContextAddLineToPoint(context, CGRectGetMinX(bounds), CGRectGetMaxY(bounds))
        CGContextStrokePath(context)
        */
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

