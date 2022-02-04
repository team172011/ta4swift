//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 01.02.22.
//

import Foundation

/**
 Crossed up rule that is satisfied when the value of the first inidcator crosses up
 the value of the second indicator or treshold
 */
public struct CrossedUpRule: Rule {
    
    public let indicator: CrossedIndicator
    
    public init(indicator1: ValueIndicator, indicator2: ValueIndicator) {
        self.indicator = CrossedIndicator(indicator1: indicator2, indicator2: indicator1)
    }
    
    public init(indicator1: ValueIndicator, treshold: Double) {
        self.indicator = CrossedIndicator(constant: treshold, indicator2: indicator1)
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int) -> Bool {
        return indicator.f(barSeries, index)
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int, record: TradingRecord) -> Bool {
        return isSatisfied(barSeries, for: index)
    }
}
