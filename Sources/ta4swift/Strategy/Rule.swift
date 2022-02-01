//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 23.01.22.
//

import Foundation

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
