//
//  ViewController.swift
//  Calculator
//
//  Created by Pradyumna Shembekar on 8/17/15.
//  Copyright (c) 2015 Pradyumna Shembekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var decimal: UIButton!
    
    var userIsTyping = false
    
    @IBOutlet weak var historyLabel: UILabel!
    
    let brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        let pi = M_PI
        
        var decimalPresent: Bool {
            if display.text!.rangeOfString(".") != nil {
                return true
            }
            return false
        }
        
        println("\(decimalPresent)")
        if decimalPresent {
            decimal.enabled = false
        }
        if !userIsTyping && digit == "π" {
            displayValue = pi
        }
            if userIsTyping {
                display.text! = display.text! + digit
            }
            else {
                display.text! = digit
                userIsTyping = true
        }
    }

    @IBAction func operation(sender: UIButton) {
        if let calculation = sender.currentTitle {
            if let result = brain.performOperation(calculation) {
                displayValue = result
            }
        }
        if userIsTyping {
            enter()
        }
        
        enter()
   }

        var displayValue: Double {
        get {
            
            return display.text!.toDouble()!
        }
        set {
            display.text = "\(newValue)"
        }
    }
    
    @IBAction func enter() {
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        userIsTyping = false
        decimal.enabled = true
    }
    
    
    @IBAction func clear() {
        brain.clear()
        display.text = "0"
        userIsTyping = false
        decimal.enabled = true
    }
}
extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}

