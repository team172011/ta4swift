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
        return isUnstableAt(index: index) && entryRule.isSatisfied(for: index, record: record)
    }
    
    public func shouldExit(index: Int, record: TradingRecord) -> Bool {
        return isUnstableAt(index: index) && exitRule.isSatisfied(for: index, record: record)
    }
    
}

public protocol Rule {
    
    func isSatisfied(for index: Int) -> Bool
    func isSatisfied(for index: Int, record: TradingRecord) -> Bool
}

extension Rule {
    
    func and(_ rule: Rule) -> Rule {
        return AndRule(rule1: self, rule2: rule)
    }
    
    func or(_ rule: Rule) -> Rule {
        return OrRule(rule1: self, rule2: rule)
    }
    
    func xor(_ rule: Rule) -> Rule {
        return XOrRule(rule1: self, rule2: rule)
    }
    
    func negation() -> Rule {
        return NotRule(rule: self)
    }
}

public struct AndRule: Rule {
    
    public let rule1: Rule
    public let rule2: Rule
    
    public init(rule1: Rule, rule2: Rule) {
        self.rule1 = rule1
        self.rule2 = rule2
    }
    
    public func isSatisfied(for index: Int) -> Bool{
        return rule1.isSatisfied(for: index) && rule2.isSatisfied(for: index)
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool{
        return rule1.isSatisfied(for: index, record: record) && rule2.isSatisfied(for: index, record: record)
    }
    
}

public struct NotRule: Rule {
    
    public let rule: Rule
    
    public init(rule: Rule) {
        self.rule = rule
    }
    
    public func isSatisfied(for index: Int) -> Bool{
        return !rule.isSatisfied(for: index)
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool{
        return !rule.isSatisfied(for: index, record: record)
    }
    
}

public struct OrRule: Rule {
    
    public let rule1: Rule
    public let rule2: Rule
    
    public init(rule1: Rule, rule2: Rule) {
        self.rule1 = rule1
        self.rule2 = rule2
    }
    
    public func isSatisfied(for index: Int) -> Bool{
        return rule1.isSatisfied(for: index) || rule2.isSatisfied(for: index)
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool{
        return rule1.isSatisfied(for: index, record: record) || rule2.isSatisfied(for: index, record: record)
    }
    
}

public struct XOrRule: Rule {
    
    let rule1: Rule
    let rule2: Rule
    
    public init(rule1: Rule, rule2: Rule) {
        self.rule1 = rule1
        self.rule2 = rule2
    }
    
    public func isSatisfied(for index: Int) -> Bool{
        return rule1.isSatisfied(for: index) ^ rule2.isSatisfied(for: index)
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool{
        return rule1.isSatisfied(for: index, record: record) ^ rule2.isSatisfied(for: index, record: record)
    }
    
}

public struct BooleanRule: Rule {
    
    public let satisfied: Bool
    
    public init(_ satisfied: Bool) {
        self.satisfied = satisfied
    }
    
    public func isSatisfied(for index: Int) -> Bool {
        return satisfied
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool {
        return satisfied
    }
    
}

extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}
