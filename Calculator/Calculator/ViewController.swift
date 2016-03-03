//
//  ViewController.swift
//  Calculator
//
//  Created by Subinkrishna Gopi on 2/12/16.
//  Copyright © 2016 Subinkrishna Gopi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel! // Implicitly unwrapped optional
    
    var isUserTyping = false
    // Same as - var isUserTyping: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        // NOTE:
        // ! kinda casts "optional" string to string
        // optionals can take either nil or optional type as value
        let digit = sender.currentTitle!
        
        // Prints to the console
        // \(digit) - converts digit to string
        // print("digit = \(digit)")
        
        if isUserTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isUserTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
            // Conventional way
            case "×": performOperation(multiply)
            // Closures baby!
            case "÷": performOperation({ (op1: Double, op2: Double) -> Double in return op2 / op1 })
            case "+": performOperation({ (op1, op2) in op1 + op2 })
            case "-": performOperation({ $1 - $0 })
            // If the func is the last argument we can do this
            // performOperation { $1 - $0 }
            case "√": performOperation { sqrt($0) }
            default:
                break
        }
    }
    
    // Argument is a method that takes two Double values as parameters
    // and returns a Double
    func performOperation(operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            // Perform the operation
            // displayValue.set will get called on assigning a value to it
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast());
            enter()
        }
    }
    
    // Good old overloading
    //
    // NOTE: 
    // @nonobjc is added to void issues in method overloading.
    // Other possible solution is to make the method private
    @nonobjc
    func performOperation(operation: Double -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast());
            enter()
        }
    }
    
    
    // Arithmetic functions
    
    func multiply(op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    
    
    var operandStack = Array<Double>()
    // Same as - var operandStack: Array<Double> = Array<Double>()
    
    @IBAction func enter() {
        isUserTyping = false
        operandStack.append(displayValue)
        print("Operand stack: \(operandStack)")
    }
    
    
    // Computed properties
    var displayValue: Double {
        get {
            // Converts string to double
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            isUserTyping = false
        }
    }
}

