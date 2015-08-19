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
    var userIsTyping = false
    var opStack = [Double]()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            display.text! = display.text! + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }


    @IBAction func operation(sender: UIButton) {
        let calculation = sender.currentTitle!
        enter()
        switch calculation {
        case "÷": performOperation() { $1 / $0 }
        case "×": performOperation() { $0 * $1 }
        case "−": performOperation() { $1 - $0 }
        case "+": performOperation() { $0 + $1 }
        default: break
        }
   }

    func performOperation(operation: (Double, Double) -> Double) {
        if opStack.count >= 2 {
            displayValue = operation(opStack.removeLast(), opStack.removeLast())
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
    }
    
    
    @IBAction func clear() {
        opStack.removeAll()
        println("opStack = \(opStack)")
        display.text = "0"
    }
    


}
extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}

