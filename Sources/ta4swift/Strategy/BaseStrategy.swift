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
    
    public func shouldEnter(index: Int, record: TradingRecord) -> Bool {
        return !isUnstableAt(index: index) &&
            entryRule.isSatisfied(for: index, record: record)
    }
    
    public func shouldExit(index: Int, record: TradingRecord) -> Bool {
        return !isUnstableAt(index: index) &&
            exitRule.isSatisfied(for: index, record: record)
    }
    
    public func canEnter(record: TradingRecord) -> Bool {
        return !record.hasOpenPosition
    }
    
    public func canExit(record: TradingRecord) -> Bool {
        return record.hasOpenPosition
    }
    
}
