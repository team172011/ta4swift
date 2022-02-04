//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 31.01.22.
//

import Foundation
import CloudKit

public struct BaseStrategy: Strategy {
       
    public let entryRule: Rule
    public let exitRule: Rule
    
    public var unstablePeriod = 0
    
    public init(entryRule: Rule, exitRule: Rule) {
        self.entryRule = entryRule
        self.exitRule = exitRule
    }
    
    public func isUnstableAt(index: Int) -> Bool {
        return unstablePeriod > index
    }
    
    public func shouldEnter(_ barSeries: BarSeries, index: Int, record: TradingRecord) -> Bool {
        return !isUnstableAt(index: index) &&
            entryRule.isSatisfied(barSeries, for: index, record: record)
    }
    
    public func shouldExit(_ barSeries: BarSeries, index: Int, record: TradingRecord) -> Bool {
        return !isUnstableAt(index: index) &&
            exitRule.isSatisfied(barSeries, for: index, record: record)
    }
    
    public func canEnter(_ barSeries: BarSeries, record: TradingRecord) -> Bool {
        return !record.hasOpenPosition
    }
    
    public func canExit(_ barSeries: BarSeries, record: TradingRecord) -> Bool {
        return record.hasOpenPosition
    }
    
}
