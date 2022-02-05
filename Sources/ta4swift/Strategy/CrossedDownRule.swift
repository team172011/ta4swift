//
//  File 2.swift
//  
//
//  Created by Simon-Justus Wimmer on 01.02.22.
//

import Foundation

/**
 Crossed down rule that is satisfied when the value of the first inidcator crosses down
 the value of the second indicator or treshold
 */
public struct CrossedDownRule: Rule {
    
    public let indicator: CrossedIndicator
    
    public init<T:ValueIndicator, U:ValueIndicator>(indicator1: T, indicator2: U) {
        self.indicator = CrossedIndicator(indicator1: indicator1, indicator2: indicator2)
    }
    
    public init<T: ValueIndicator>(indicator1: T, treshold: Double) {
        self.indicator = CrossedIndicator(indicator1: indicator1, constant: treshold)
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int) -> Bool {
        return indicator.f(barSeries, index)
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int, record: TradingRecord) -> Bool {
        return isSatisfied(barSeries, for: index)
    }
}
