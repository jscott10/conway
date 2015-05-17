//
//  ViewController.swift
//  conway
//
//  Created by James Scott on 12/2/14.
//  Copyright (c) 2014 James Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var g1: UITapGestureRecognizer!
    var g2: UITapGestureRecognizer!
    
    var tapAction: Selector!
    
    @IBOutlet weak var gridView: CellGridView!
    
    @IBOutlet weak var speedStepper: UIStepper!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var densitySlider: UISlider!
    @IBOutlet weak var densityLabel: UILabel!
    
    @IBOutlet weak var gridWidthSlider: UISlider!
    @IBOutlet weak var gridWidthLabel: UILabel!
    
    @IBOutlet weak var iterationLabel: UILabel!
    
    var world: World!
    
    var running: Bool = false
    
    // Number of Cells ACROSS
    var gridWidth: Int = 50
    
    // Number of Cells DOWN
    var gridHeight: Int = 50
    
    // % of grid populated
    var density = 25
    
    // Speed control
    var delay: NSTimeInterval = 0.0
    
    // Speed control loop
    var timer: NSTimer!
    
    @IBAction func speedValueChanged(sender: UIStepper) {
        stopIterating()
        delay = sender.value == 10.0 ? NSTimeInterval(0.0) : NSTimeInterval((10 - sender.value) / 10)
        speedLabel.text = "\(sender.value)"
        startIterating()
    }
    
    @IBAction func gridWidthValueChanged(sender: UISlider) {
        stopIterating()
        gridWidth = Int(sender.value)
        gridHeight = gridWidth
        
        gridWidthLabel.text = "\(gridWidth)"
        
        world.resizeGrid(newWidth: gridWidth, newHeight: gridHeight)
//        resetWorld()
        
        gridView.grid = world.currentGrid
//        gridView.lastgrid = world.nextGrid
        gridView.setNeedsDisplay()
    }
    
    @IBAction func finishedDraggingWidthSlider(sender: UISlider) {
        restartWorld()
    }
    
    @IBAction func densityValueChanged(sender: UISlider) {
        stopIterating()
        density = lroundf(sender.value)
        densityLabel.text = "\(density)"
        resetWorld()
        
        gridView.grid = world.currentGrid
        gridView.setNeedsDisplay()
    }
    
    func resetWorld() {
        stopIterating()
        world.reset()
        world.currentGrid.randomize(density: density)
 //       world.currentGrid.setupPulsar()
    }
    
    func restartWorld() {
        resetWorld()
        gridView.grid = world.currentGrid
        gridView.setNeedsDisplay()
        iterationLabel.text = "\(world.iteration)"
    }
    
    func startIterating() {
        println("started!!!!!!!")
        if !running {
            timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: Selector("iterateGrid"), userInfo: nil, repeats: true)
            running = true
            g2.enabled = false
            g1 = UITapGestureRecognizer(target: self, action: "stopIterating")
            g1.numberOfTapsRequired = 1
            g1.numberOfTouchesRequired = 1
            gridView.addGestureRecognizer(g1)
        }
    }
    
    func stopIterating() {
        println("stopped!!!!!!!")
        if running  {
            running = false
            timer.invalidate()
            g1 = UITapGestureRecognizer(target: self, action: "startIterating")
            g1.numberOfTapsRequired = 1
            g1.numberOfTouchesRequired = 1
            gridView.addGestureRecognizer(g1)
            g2.enabled = true
            g1.requireGestureRecognizerToFail(g2)
        }
    }
    
    func toggleIteration()  {
        if running  {
            stopIterating()
        }
        else    {
            startIterating()
        }
    }

    func iterateGrid() {
        world.process()
//        gridView.lastgrid = world.nextGrid
        gridView.grid = world.currentGrid
        gridView.setNeedsDisplay()
        iterationLabel.text = "\(world.iteration)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridView.bounds.size = CGSizeMake(view.bounds.width, view.bounds.height)
        
        // Set grid width and slider label from slider value
        let maxGridWidth = (gridView.bounds.width - 1.0) / 2.0
        gridWidthSlider.maximumValue = Float(maxGridWidth)
        gridWidth = Int(gridWidthSlider.value)
        gridWidthLabel.text = "\(gridWidth)"
        
        // Square grid for now
        gridHeight = gridWidth
        
        // Set grid density and slider label from slider value
        density = Int(densitySlider.value)
        densityLabel.text = "\(density)"
        
        // Set delay and speed stepper label from slider value
        delay = speedStepper.value == 10.0 ? NSTimeInterval(0.0) : NSTimeInterval((10 - speedStepper.value) / 10)
        speedLabel.text = "\(speedStepper.value)"
//        delay = NSTimeInterval(speedStepper.value/10.0)
//        speedLabel.text = "\(10-speedStepper.value)"
        
        world = World(gridWidth: gridWidth, gridHeight: gridHeight)
        resetWorld()
        
        g1 = UITapGestureRecognizer(target: self, action: "startIterating")
        g1.numberOfTapsRequired = 1
        g1.numberOfTouchesRequired = 1
        gridView.addGestureRecognizer(g1)
        
        g2 = UITapGestureRecognizer(target: self, action: "restartWorld")
        g2.numberOfTapsRequired = 2
        g2.numberOfTouchesRequired = 1
        gridView.addGestureRecognizer(g2)
        g1.requireGestureRecognizerToFail(g2)
        
        println("w: \(self.view.frame.size.width)")
        println("h: \(self.view.frame.size.height)")
        
//        w.currentGrid.setupPulsar()
//        w.currentGrid.setupGlider()
        
        gridView.grid = world.currentGrid
//        gridView.lastgrid = world.nextGrid
        
        gridView.setNeedsDisplay()
        
        println("**** gridView.frame = \(gridView.bounds.minX) - \(gridView.bounds.maxX) by \(gridView.bounds.minY) - \(gridView.bounds.maxY) *****")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

