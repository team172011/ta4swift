//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 25.01.22.
//

import Foundation

public struct BooleanRule: Rule {
    
    public let satisfied: () -> Bool
    
    public init(_ satisfied: @escaping () -> Bool) {
        self.satisfied = satisfied
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int) -> Bool {
        return satisfied()
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int, record: TradingRecord) -> Bool {
        return satisfied()
    }
    
}
