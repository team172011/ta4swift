//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct BinaryOperation: ValueIndicator {
    
    public var barSeries: BarSeries
    public let left: ValueIndicator
    public let right: ValueIndicator
    
    let operation: (Double, Double) -> Double
    
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
        self.barSeries = left.barSeries
        self.left = left
        self.right = right
        self.operation = operation
    }
    
    public func getValue(for index: Int) -> Double {
        return operation(left.getValue(for: index), right.getValue(for: index));
    }
    
}
