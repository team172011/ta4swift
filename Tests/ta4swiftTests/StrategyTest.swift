//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 17.01.22.
//

import Foundation
import ta4swift

public class StrategyTest: Ta4swiftTest {
    
    let falseRule = BooleanRule(false)
    let falseRule2 = BooleanRule(false)
    let trueRule = BooleanRule(true)
    let trueRule2 = BooleanRule(true)
    
    func testLogicRule() throws {

        let andRule = AndRule(rule1: falseRule, rule2: trueRule);
        
        assert(andRule.isSatisfied(for: 0) == false)
        assert(andRule.isSatisfied(for: 5) == false)
        assert(andRule.isSatisfied(for: 100) == false)
        
        let andRule2 = AndRule(rule1: trueRule, rule2: trueRule2)
        
        assert(andRule2.isSatisfied(for: 0) == true)
        assert(andRule2.isSatisfied(for: 5) == true)
        assert(andRule2.isSatisfied(for: 100) == true)
        
        let orRule = XOrRule(rule1: trueRule, rule2: falseRule)
        
        assert(orRule.isSatisfied(for: 0) == true)
        assert(orRule.isSatisfied(for: 5) == true)
        
        let orRule2 = OrRule(rule1: trueRule, rule2: trueRule2)
        
        assert(orRule2.isSatisfied(for: 0) == true)
        assert(orRule2.isSatisfied(for: 5) == true)
        
        let orRule3 = OrRule(rule1: falseRule, rule2: falseRule2)
        
        assert(orRule3.isSatisfied(for: 0) == false)
        assert(orRule3.isSatisfied(for: 5) == false)
        
        let xOrRule = OrRule(rule1: trueRule, rule2: falseRule)
        
        assert(xOrRule.isSatisfied(for: 0) == true)
        assert(xOrRule.isSatisfied(for: 5) == true)
        
        let xOrRule2 = XOrRule(rule1: trueRule, rule2: trueRule2)
        
        assert(xOrRule2.isSatisfied(for: 0) == false)
        assert(xOrRule2.isSatisfied(for: 5) == false)
    }
}
