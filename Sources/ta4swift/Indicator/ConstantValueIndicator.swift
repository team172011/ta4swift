//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct ConstantValueIndicator: ValueIndicator {
    
    public var constant: Double
    public var barSeries: BarSeries
    
    public init(barSeries: BarSeries, constant: Double) {
        self.barSeries = barSeries
        self.constant = constant
    }
    
    public func getValue(for index: Int) -> Double {
        return self.constant
    }
}
