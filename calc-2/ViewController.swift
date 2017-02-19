//
//  ViewController.swift
//  calc-2
//
//  Created by Vikrant on 20/01/17.
//  Copyright © 2017 Vikrant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    private var userIsInTheMiddleOfTyping = false
    private var calObj = CalculatorModel()
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.layer.cornerRadius = 10.0
        btn.clipsToBounds = true
    }
    
    @IBAction private func numberPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    
    @IBAction private func operatorPressed(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            calObj.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            calObj.performOperation(symbol: mathSymbol)
        }
        displayValue = calObj.result
    }

}

