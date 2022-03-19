//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct BinaryOperation: ValueIndicator {
    
    public var cached: Bool = false
    public var calc: (BarSeries, Int) -> Double
    
    static func sum(left: ValueIndicator, right: ValueIndicator) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { $0 + $1 }
    }
    
    static func difference(left: ValueIndicator, right: ValueIndicator) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { $0 - $1 }
    }
    
    static func product(left: ValueIndicator, right: ValueIndicator) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { $0 * $1 }
    }
    
    static func quotient(left: ValueIndicator, right: ValueIndicator) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { $0 / $1 }
    }
    
    static func min(left: ValueIndicator, right: ValueIndicator) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { Swift.min($0,$1) }
    }
    
    static func max(left: ValueIndicator, right: ValueIndicator) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { Swift.max($0,$1) }
    }
    
    public init(left: ValueIndicator, right: ValueIndicator, _ operation: @escaping (Double, Double) -> Double) {
        self.calc = { operation(left.calc($0, $1), right.calc($0, $1)) }
    }
    
    
}
