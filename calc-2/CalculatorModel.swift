//
//  CalculatorModel.swift
//  calc-2
//
//  Created by Vikrant on 31/01/17.
//  Copyright © 2017 Vikrant. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    private var accumulator = 0.0
    private var pending: pendingBinaryInfo?
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperator(let function):
                accumulator = function(accumulator)
            case .BinaryOperator(let function):
                executePendingBinaryOperation()
                pending = pendingBinaryInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "∏" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperator(sqrt),
        "cos" : Operation.UnaryOperator(cos),
        "×" : Operation.BinaryOperator({$0 * $1}),
        "+" : Operation.BinaryOperator({$0 + $1}),
        "-" : Operation.BinaryOperator({$0 - $1}),
        "÷" : Operation.BinaryOperator({$0 / $1}),
        "=" : Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperator((Double) -> Double)
        case BinaryOperator((Double, Double) -> Double)
        case Equals
    }
    
    private struct pendingBinaryInfo {
        var binaryFunction: ((Double, Double) -> Double)
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
