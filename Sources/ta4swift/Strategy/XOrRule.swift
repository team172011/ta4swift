//
//  File 3.swift
//  
//
//  Created by Simon-Justus Wimmer on 01.02.22.
//

import Foundation

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


extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}
