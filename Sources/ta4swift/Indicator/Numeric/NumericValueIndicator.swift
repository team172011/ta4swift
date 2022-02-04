//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public protocol NumericOperations {
    
    func minus(indicator: ValueIndicator) -> NumericIndicator
    func plus(indicator: ValueIndicator) -> NumericIndicator
    func multiply(indicator: ValueIndicator) -> NumericIndicator
    func divide(indicator: ValueIndicator) -> NumericIndicator
    func min(indicator: ValueIndicator) -> NumericIndicator
    func max(indicator: ValueIndicator) -> NumericIndicator
    
    func sqrt() -> NumericIndicator
    func abs() -> NumericIndicator
}

public struct NumericIndicator: ValueIndicator, NumericOperations {
    
    public func minus(indicator: ValueIndicator) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.difference(left: self, right: indicator) }
    }
    
    public func plus(indicator: ValueIndicator) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.sum(left: self, right: indicator) }
    }
    
    public func multiply(indicator: ValueIndicator) -> NumericIndicator {
        return NumericIndicator { BinaryOperation.product(left: self, right: indicator) }
    }
    
    public func divide(indicator: ValueIndicator) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.quotient(left: self, right: indicator) }
    }
    
    public func min(indicator: ValueIndicator) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.min(left: self, right: indicator) }
    }
    
    public func max(indicator: ValueIndicator) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.max(left: self, right: indicator) }
    }
    
    public func sqrt() -> NumericIndicator {
        return NumericIndicator{ UnaryOperation.sqrt(indicator: self) }
    }
    
    public func abs() -> NumericIndicator {
        return NumericIndicator { UnaryOperation.abs(indicator: self)}
    }
    
    
    public let delegate: ValueIndicator
    
    public var barSeries: BarSeries {
        get {
            return delegate.barSeries;
        }
    }
    
    init(_ indicator: () -> ValueIndicator) {
        self.delegate = indicator();
    }
    
    public func getValue(for index: Int) -> Double {
        return delegate.getValue(for: index)
    }
    
}
