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
    var opStack = [Double]()
    @IBOutlet weak var historyLabel: UILabel!
    
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
        let calculation = sender.currentTitle!
        if userIsTyping {
            enter()
        }
        switch calculation {
        case "÷": binaryOperation() { $1 / $0 }
        case "×": binaryOperation() { $0 * $1 }
        case "−": binaryOperation() { $1 - $0 }
        case "+": binaryOperation() { $0 + $1 }
        case"√": unaryOperation() { sqrt($0) }
        case "sin": unaryOperation() { sin($0) }
        case "cos": unaryOperation() { cos($0) }
        default: break
        }
        enter()
   }

    func binaryOperation(operation: (Double, Double) -> Double) {
        if opStack.count >= 2 {
        displayValue = operation(opStack.removeLast(), opStack.removeLast())
        }
    }
    
    func unaryOperation(operation: Double -> Double) {
        if opStack.count >= 1 {
        displayValue = operation(opStack.removeLast())
        }
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
        userIsTyping = false
        opStack.append(displayValue)
        println("opStack = \(opStack)")
        decimal.enabled = true
    }
    
    
    @IBAction func clear() {
        opStack.removeAll()
        println("opStack = \(opStack)")
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

