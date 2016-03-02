//
//  ViewController.swift
//  calculator
//
//  Created by Tonni Hyldgaard on 2/25/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Multiply = "x"
        case Divide = "/"
        case Subtract = "-"
        case Addition = "+"
        case Equals = "="
        case Empty = "Empty"
    }
    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var acButton: UIButton!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValue = ""
    var rigthValue = ""
    var currentOperator: Operation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = NSBundle.mainBundle().pathForResource("btnpress", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        btnSound.play()
        runningNumber += "\(btn.tag)"
        sumLabel.text = runningNumber
        acButton.setTitle("C", forState: UIControlState.Normal)

    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
    }
   
    @IBAction func onSubtractPressed(sender: AnyObject) {
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject) {
    }
   
    @IBAction func onEqualPressed(sender: AnyObject) {
    }
    
    @IBAction func onProcentagePressed(sender: AnyObject) {
    }

    @IBAction func onChangeSignPressed(sender: AnyObject) {
    }
    
    @IBAction func onAllClearPressed(sender: AnyObject) {
        
        if runningNumber != "0" && rigthValue != "0" && leftValue != "0" {
            acButton.setTitle("C", forState: UIControlState.Normal)
            runningNumber = "0"
            sumLabel.text = runningNumber
        } else {
            runningNumber = ""
            sumLabel.text = "0"
            leftValue = ""
            rigthValue = ""
            currentOperator = Operation.Empty
            acButton.setTitle("AC", forState: UIControlState.Normal)

        }
    }
    
    @IBAction func onDeletePressed(sender: AnyObject) {
        runningNumber.removeAtIndex(runningNumber.endIndex.predecessor())
        sumLabel.text = runningNumber
    }
    
    @IBAction func onCommaDoubleValuePressed(sender: AnyObject) {
    }
    
    
}

