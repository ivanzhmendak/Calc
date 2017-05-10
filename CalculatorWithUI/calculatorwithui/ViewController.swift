//
//  ViewController.swift
//  CalculatorWithUI
//
//  Created by Kirill Kirikov on 5/7/17.
//  Copyright © 2017 GoIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var didInputStarted:Bool = false
    var model = CalculatorModel()
    var currentDisplayValue: Double {
        set {
            inputDisplay.text = String(newValue)
        }
        get {
            return Double(inputDisplay.text!)!
        }
    }
    
    @IBOutlet weak var inputDisplay: UITextField!
    
    @IBAction func touchDigit(_ sender: UIButton) {
        print("Digit: \(sender.currentTitle!)")
        
        if didInputStarted {
            inputDisplay.text = inputDisplay.text! + sender.currentTitle!
        } else if sender.currentTitle! != "0" {
            inputDisplay.text = sender.currentTitle!
            didInputStarted = true
        }

    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        guard let currentValue = Double(inputDisplay.text!) else {
            return
        }
        
        model.setOperand(currentValue)
        model.performOperation(sender.currentTitle!)
        currentDisplayValue = model.result ?? 0
        
        didInputStarted = false
    }
    @IBAction func putADot(_ sender: UIButton) {
        if didInputStarted {
            if !((inputDisplay.text?.contains("."))!){
                inputDisplay.text = "\(inputDisplay.text!)."
//                inputDisplay.text! += "."
            }
        
        } else {
            inputDisplay.text = "0."
            didInputStarted = true
        }
    }
    
}
