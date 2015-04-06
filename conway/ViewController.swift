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
    
    var timer: NSTimer!
    
    @IBOutlet weak var changeInitialDensity: UISlider!
    
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
        
        w.resetWorld(density)
        
        //        w.currentGrid.setupPulsar()
        //        w.currentGrid.setupGlider()
        
        displayGrid(w.currentGrid, cellSize: 5)
    }
    
    @IBAction func changeInitialDensity(sender: UISlider) {

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
            timer = NSTimer.scheduledTimerWithTimeInterval(0.06, target: self, selector: Selector("iterateGrid"), userInfo: nil, repeats: true)
            resetButton.enabled = false
            startButton.setTitle("Stop", forState: .Normal)
       }
    }
    
    func iterateGrid() {
        w.processWorld()
        displayGrid(w.currentGrid, cellSize: 5)
        iterationDisplay.text = "\(w.iteration)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        boardWidthStepper.maximumValue = Double(self.view.frame.size.width)
//        boardHeightStepper.maximumValue = Double(self.view.frame.size.height)
        

        var boardWidth = 17
        var boardHeight = 17
        var cellSize = 5
        
        w = World(gridWidth: 100, gridHeight: 100)
        
        println("w: \(self.view.frame.size.width)")
        println("h: \(self.view.frame.size.height)")
        println("cell mem size: \(sizeof(Cell))")
        println("grid mem size: \(sizeofValue(w.currentGrid))")
        
        w.resetWorld(density)
//        w.currentGrid.setupPulsar()
//        w.currentGrid.setupGlider()
        
        displayGrid(w.currentGrid, cellSize: cellSize)
        
    }
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

