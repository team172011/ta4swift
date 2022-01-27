//
//  File.swift
//  
//
//

import Foundation


public protocol Strategy {
    
    var entryRule: Rule { get }
    var exitRule: Rule { get }
    var unstablePeriod: Int { get set}
    
    func isUnstableAt(index: Int) -> Bool
    func shouldEnter(index: Int, record: TradingRecord) -> Bool
    func shouldExit(index: Int, record: TradingRecord) -> Bool
}

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
        return !isUnstableAt(index: index) && entryRule.isSatisfied(for: index, record: record)
    }
    
    public func shouldExit(index: Int, record: TradingRecord) -> Bool {
        return !isUnstableAt(index: index) && exitRule.isSatisfied(for: index, record: record)
    }
    
}
