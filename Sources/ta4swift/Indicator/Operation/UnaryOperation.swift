//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct UnaryOperation: ValueIndicator {
    public var cached: Bool = false

    public var calc: (BarSeries, Int) -> Double

    public static func abs<T: ValueIndicator>(indicator: T) -> UnaryOperation {
        UnaryOperation(for: indicator){ Swift.abs($0) }
    }
    
    public static func sqrt<T: ValueIndicator>(indicator: T) -> UnaryOperation {
        UnaryOperation(for: indicator){ $0.squareRoot() }
    }
    
    public init<T: ValueIndicator>(for indicator: T, _ operation: @escaping ( Double) -> Double) {
        self.calc = { operation(indicator.calc($0, $1)) }
    }
    
}
