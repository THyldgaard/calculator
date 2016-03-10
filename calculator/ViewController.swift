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
        case Procentage = "%"
        case Opposite = "+ / -"
        case Equal = "="
        case Comma = ","
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var acButton: UIButton!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValue = ""
    var rigthValue = ""
    var currentOperator: Operation = Operation.Empty
    var result = ""
    
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
        
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playButtonSound()
        runningNumber += "\(btn.tag)"
        updateSumLabel(runningNumber)
        changeACButtonText("C")
        
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
        
    }
   
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
        
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Addition)
        
    }
   
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperator)
        
    }
    
    @IBAction func onProcentagePressed(sender: AnyObject) {
        processOperation(Operation.Procentage)
        
    }

    @IBAction func onChangeSignPressed(sender: AnyObject) {
        processOperation(Operation.Opposite)
        
    }
    
    @IBAction func onAllClearPressed(sender: AnyObject) {
        playButtonSound()
        runningNumber = ""
        leftValue = ""
        rigthValue = ""
        currentOperator = Operation.Empty
        zeroUpdateSumLabel()
        
    }
    
    @IBAction func onDeletePressed(sender: AnyObject) {
        playButtonSound()
        if (runningNumber != "" && runningNumber.characters.count > 1) {
            runningNumber.removeAtIndex(runningNumber.endIndex.predecessor())
            updateSumLabel(runningNumber)
        } else {
            if runningNumber.characters.count == 1 {
                runningNumber.removeAtIndex(runningNumber.endIndex.predecessor())
            }
            zeroUpdateSumLabel()
        }
    
    }
    
    @IBAction func onCommaDoubleValuePressed(sender: AnyObject) {
        playButtonSound()
        runningNumber += "."
        
    }
    
    func processOperation(op: Operation) {
        playButtonSound()
        
        if currentOperator != Operation.Empty {
            if runningNumber != "" {
                rigthValue = runningNumber
                runningNumber = ""
                
                if currentOperator == Operation.Multiply {
                    result = "\(Double(leftValue)! * Double(rigthValue)!)"
                } else if currentOperator == Operation.Divide {
                    result = "\(Double(leftValue)! / Double(rigthValue)!)"
                } else if currentOperator == Operation.Subtract {
                    result = "\(Double(leftValue)! - Double(rigthValue)!)"
                } else if currentOperator == Operation.Addition {
                    result = "\(Double(leftValue)! + Double(rigthValue)!)"
                } else if currentOperator == Operation.Opposite {
                    result = "\(Double(leftValue)! * Double("-1")!)"
                } else if currentOperator == Operation.Procentage {
                    result = "\((Double(leftValue)! / 100))"
                }
                
                
            } else if runningNumber == "" {
                if currentOperator == Operation.Opposite {
                    result = "\(Double(leftValue)! * Double("-1")!)"
                } else if currentOperator == Operation.Procentage {
                    result = "\((Double(leftValue)! / 100))"
                }
            }
            
            leftValue = result
            updateSumLabel(leftValue)
            currentOperator = op
            
        } else {
            // first time an operator is pressed
            leftValue = runningNumber
            runningNumber = ""
            currentOperator = op
        }
        
    }
    
    func playButtonSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    
    func updateSumLabel(sumValue: String) {
        sumLabel.text = sumValue
        
    }
    
    func changeACButtonText(txt: String) {
        acButton.setTitle(txt, forState: UIControlState.Normal)

    }
    
    func zeroUpdateSumLabel() {
        updateSumLabel("0")
        if rigthValue != "" && leftValue != "" {
            changeACButtonText("AC")
        } else {
            changeACButtonText("C")
        }
        
    }
    
    
}

