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

/**
 Crossed down rule that is satisfied when the value of the first inidcator crosses down
 the value of the second indicator or treshold
 */
public struct CrossedDownRule: Rule {
    
    public let indicator: CrossedIndicator
    
    public init(indicator1: ValueIndicator, indicator2: ValueIndicator) {
        self.indicator = CrossedIndicator(indicator1: indicator1, indicator2: indicator2)
    }
    
    public init(indicator1: ValueIndicator, treshold: Double) {
        self.indicator = CrossedIndicator(indicator: indicator1, constant: treshold)
    }
    
    public func isSatisfied(for index: Int) -> Bool {
        return indicator.getValue(for: index)
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool {
        return isSatisfied(for: index)
    }
}

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
        self.indicator = CrossedIndicator(constant: treshold, indicator: indicator1)
    }
    
    public func isSatisfied(for index: Int) -> Bool {
        return indicator.getValue(for: index)
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool {
        return isSatisfied(for: index)
    }
}

extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}
