//
//  CalculatorModel.swift
//  CalculatorWithUI
//
//  Created by Kirill Kirikov on 5/7/17.
//  Copyright © 2017 GoIT. All rights reserved.
//

import Foundation

struct CalculatorModel {
    
    private typealias UnaryFunction     = (Double) -> Double
    private typealias BinaryFunction    = (Double, Double) -> Double
    
    private enum Operation {
        case constant(Double)
        case unary(UnaryFunction)
        case binary(BinaryFunction)
        case equal
    }
    
    private struct PendingBinaryOperation {
        let firstOperand    :Double
        let function        :BinaryFunction
        
        func performOperation(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var accomulator:Double?
    private var pbo:PendingBinaryOperation?
    private let operations: [String:Operation] = [
        "±"     : Operation.unary(-),
        "√"     : Operation.unary(sqrt),
        "sin"   : Operation.unary(sin),
        "cos"   : Operation.unary(cos),
        "π"     : Operation.constant(Double.pi),
        "CE"    : Operation.constant(0),
        "exp"   : Operation.constant(M_E),
        "+"     : Operation.binary(+),
        "−"     : Operation.binary(-),
        "×"     : Operation.binary(*),
        "÷"     : Operation.binary(/),
        "="     : Operation.equal,
        "π/2"   : Operation.constant((Double.pi)/2)
    ]
    
    mutating func setOperand(_ operand: Double) {
        accomulator = operand
    }
    
    mutating func performOperation(_ symbol:String) {
        
        guard let operation = operations[symbol] else {
            return
        }
        
        switch operation {
            case .constant(let value):
                accomulator = value
            case .unary(let f):
                if accomulator != nil {
                    accomulator = f(accomulator!)
                }
            case .binary(let f):
                if accomulator != nil {
                    pbo = PendingBinaryOperation(firstOperand: accomulator!, function: f)
                }
            case .equal:
                if pbo != nil && accomulator != nil {
                    accomulator = pbo!.performOperation(with: accomulator!)
                    pbo = nil
                }

                break
        }
    }
    
    var result:Double? {
        get {
            return accomulator
        }
    }
}
