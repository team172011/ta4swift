//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public protocol NumericOperations {
    
    func minus<T: ValueIndicator>(_ indicator: T) -> NumericIndicator
    func plus<T: ValueIndicator>(_ indicator: T) -> NumericIndicator
    func multiply<T: ValueIndicator>(_ indicator: T) -> NumericIndicator
    func divide<T: ValueIndicator>(_ indicator: T) -> NumericIndicator
    func min<T: ValueIndicator>(_ indicator: T) -> NumericIndicator
    func max<T: ValueIndicator>(_ indicator: T) -> NumericIndicator
    
    func sqrt() -> NumericIndicator
    func abs() -> NumericIndicator
}

public struct NumericIndicator: ValueIndicator, NumericOperations {
    
    public func minus<T: ValueIndicator>(_ indicator: T) -> NumericIndicator {
        return NumericIndicator { BinaryOperation.difference(left: self, right: indicator) }
    }
    
    public func plus<T: ValueIndicator>(_ indicator: T) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.sum(left: self, right: indicator) }
    }
    
    public func multiply<T: ValueIndicator>(_ indicator: T) -> NumericIndicator {
        return NumericIndicator { BinaryOperation.product(left: self, right: indicator) }
    }
    
    public func divide<T: ValueIndicator>(_ indicator: T) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.quotient(left: self, right: indicator) }
    }
    
    public func min<T: ValueIndicator>(_ indicator: T) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.min(left: self, right: indicator) }
    }
    
    public func max<T: ValueIndicator>(_ indicator: T) -> NumericIndicator {
        return NumericIndicator{ BinaryOperation.max(left: self, right: indicator) }
    }
    
    public func sqrt() -> NumericIndicator {
        return NumericIndicator{ UnaryOperation.sqrt(indicator: self) }
    }
    
    public func abs() -> NumericIndicator {
        return NumericIndicator { UnaryOperation.abs(indicator: self)}
    }
    
    public var f: (BarSeries, Int) -> Double
    
    init<T: ValueIndicator>(_ indicator: () -> T) {
        self.f = indicator().f;
    }
    
}
