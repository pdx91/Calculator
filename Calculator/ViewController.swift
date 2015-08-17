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
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            display.text! = display.text! + digit
        } else {
            display.text! = digit
            userIsTyping = true
    }

}
}

