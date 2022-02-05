//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct BinaryOperation: ValueIndicator {
    
    public var f: (BarSeries, Int) -> Double
    
    static func sum<T:ValueIndicator,U:ValueIndicator>(left: T, right: U) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { $0 + $1 }
    }
    
    static func difference<T:ValueIndicator,U:ValueIndicator>(left: T, right: U) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { $0 - $1 }
    }
    
    static func product<T:ValueIndicator,U:ValueIndicator>(left: T, right: U) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { $0 * $1 }
    }
    
    static func quotient<T:ValueIndicator,U:ValueIndicator>(left: T, right: U) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { $0 / $1 }
    }
    
    static func min<T:ValueIndicator,U:ValueIndicator>(left: T, right: U) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { Swift.min($0,$1) }
    }
    
    static func max<T:ValueIndicator,U:ValueIndicator>(left: T, right: U) -> BinaryOperation {
        return BinaryOperation(left: left, right: right) { Swift.max($0,$1) }
    }
    
    public init<T: ValueIndicator,U:ValueIndicator>(left: T, right: U, _ operation: @escaping (Double, Double) -> Double) {
        self.f = { operation(left.f($0, $1), right.f($0, $1)) }
    }
    
    
}
