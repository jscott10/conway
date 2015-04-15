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
    
    let cellGrid: CellGridView!
    
    cellGrid = CellGridView()
    
    cellGrid
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

