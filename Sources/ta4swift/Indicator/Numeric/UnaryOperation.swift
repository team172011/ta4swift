//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct UnaryOperation: ValueIndicator {
    public var f: (BarSeries, Int) -> Double

    public static func abs(indicator: ValueIndicator) -> UnaryOperation {
        UnaryOperation(for: indicator){ Swift.abs($0) }
    }
    
    public static func sqrt(indicator: ValueIndicator) -> UnaryOperation {
        UnaryOperation(for: indicator){ $0.squareRoot() }
    }
    
    public init(for indicator: ValueIndicator, _ operation: @escaping ( Double) -> Double) {
        self.f = { operation(indicator.f($0, $1)) }
    }
    
}
