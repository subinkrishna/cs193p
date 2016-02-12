//
//  ViewController.swift
//  Calculator
//
//  Created by Subinkrishna Gopi on 2/12/16.
//  Copyright © 2016 Subinkrishna Gopi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var isUserTyping: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        // NOTE:
        // ! kinda casts "optional" string to string
        // optionals can take either nil or optional type as value
        let digit = sender.currentTitle!
        print("digit = \(digit)")
        
        if isUserTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isUserTyping = true
        }
    }
    
}

