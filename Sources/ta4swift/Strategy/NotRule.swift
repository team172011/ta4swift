//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 01.02.22.
//

import Foundation

public struct NotRule: Rule {
    
    
    public let rule: Rule
    
    public init(_ rule: () -> Rule) {
        self.rule = rule()
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int) -> Bool{
        return !rule.isSatisfied(barSeries, for: index)
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int, record: TradingRecord) -> Bool{
        return !rule.isSatisfied(barSeries, for: index, record: record)
    }
    
}
