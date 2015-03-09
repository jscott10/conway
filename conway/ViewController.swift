//
//  ViewController.swift
//  conway
//
//  Created by James Scott on 12/2/14.
//  Copyright (c) 2014 James Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var w:World!
    
    var density = 25
    
    var running: Bool = false
    
    var iteration = 0
    
    var timer: NSTimer!
    
    @IBOutlet weak var densitySlider: UISlider!
    
    @IBOutlet weak var densityValue: UILabel!
    
    @IBOutlet weak var iterationDisplay: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func resetBoard(sender: UIButton) {
        if running  {
            running = false
            timer.invalidate()
            startButton.setTitle("Start", forState: .Normal)
        }
        w.currentGrid.randomize(density)
        iteration = 0
        iterationDisplay.text = "0"
        //        w.currentGrid.setupPulsar()
        //        w.currentGrid.setupGlider()
        displayGrid(w.currentGrid, cellSize: 4)
    }
    
/*
    @IBAction func controlBar(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex  {
        case 0:
            if !running {
                timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("iterateGrid"), userInfo: nil, repeats: true)
                startButton.setTitle("Stop", forState: .Normal)
            }
        case 1:
            if running  {
                running = false
                timer.invalidate()
                startButton.setTitle("Start", forState: .Normal)
            }
        case 2:
            if running  {
                running = false
                timer.invalidate()
                startButton.setTitle("Start", forState: .Normal)
            }
            w.currentGrid.randomize(25)
        //        w.currentGrid.setupPulsar()
        //        w.currentGrid.setupGlider()
            displayGrid(w.currentGrid, cellSize: 4)
        default:
            break
        }
    }
*/
    @IBAction func densitySlider(sender: UISlider) {

        density = lroundf(sender.value)
        densityValue.text = "\(density)"
//        w.currentGrid.randomize(density)
//       w.currentGrid.printGrid()
        
    }
    
    @IBAction func updateGrid() {
        if running  {
            running = false
            timer.invalidate()
            startButton.setTitle("Start", forState: .Normal)
            resetButton.enabled = true
        }
        else    {
            running = true
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("iterateGrid"), userInfo: nil, repeats: true)
            resetButton.enabled = false
            startButton.setTitle("Stop", forState: .Normal)
       }
    }
    
    func iterateGrid() {
        w.processWorld()
        displayGrid(w.currentGrid, cellSize: 4)
        iterationDisplay.text = "\(iteration++)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var boardWidth = 17
        var boardHeight = 17
        var cellSize = 4
        
        w = World(gridWidth: 75, gridHeight: 75)
        
        println("w: \(self.view.frame.size.width)")
        println("h: \(self.view.frame.size.height)")
        
        w.currentGrid.randomize(density)
//        w.currentGrid.setupPulsar()
//        w.currentGrid.setupGlider()
        
        w.currentGrid.printGrid()
        
        displayGrid(w.currentGrid, cellSize: cellSize)
        
    }
    
    func displayGrid(grid: Grid, cellSize: Int)  {
        
        // Cells plus borders
        //        let imageWidth = grid.gridWidth * (cellSize + 1) + 3
        //        let imageHeight = grid.gridHeight * (cellSize + 1) + 3
        let imageWidth = self.view.frame.size.width
        let imageHeight = self.view.frame.size.width
        
        let cellSpacing:Int = 1
        
        let imageSize = CGSize(width: imageWidth, height: imageHeight)
        
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 20), size: imageSize))
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

    /*
    func drawBoxGrid(context: CGContext, grid: Grid, cellSide: Int)  {
        
        let cellSpacing = 1
        let cellSize = CGSize(width: cellSide, height: cellSide)
        
        // Setup complete, do drawing here
        CGContextSetFillColorWithColor(context, UIColor.brownColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        
        for (y, cellRow) in enumerate(grid.cellGrid) {
            for (x, cell) in enumerate(cellRow) {
                let xOffset = x * (cellSide + cellSpacing)
                let yOffset = y * (cellSide + cellSpacing)
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
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

