//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct UnaryOperation: ValueIndicator {
    
    public var barSeries: BarSeries
    
    let delegate: ValueIndicator
    let operation: (Double) -> Double

    public static func abs(indicator: ValueIndicator) -> UnaryOperation {
        UnaryOperation(for: indicator){ Swift.abs($0) }
    }
    
    public static func sqrt(indicator: ValueIndicator) -> UnaryOperation {
        UnaryOperation(for: indicator){ $0.squareRoot() }
    }
    
    public init(for indicator: ValueIndicator, _ operation: @escaping ( Double) -> Double) {
        self.barSeries = indicator.barSeries
        self.delegate = indicator
        self.operation = operation
    }
    
    public func getValue(for index: Int) -> Double {
        return operation(delegate.getValue(for: index))
    }
    
}
