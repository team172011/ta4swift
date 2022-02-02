//
//  File 4.swift
//  
//
//  Created by Simon-Justus Wimmer on 01.02.22.
//

import Foundation

public struct OrRule: Rule {
    
    public let rules: [Rule]
    
    public init(_ rule: () -> [Rule]) {
        self.rules = rule()
    }
    
    public func isSatisfied(for index: Int) -> Bool{
        return rules.contains{ rule in rule.isSatisfied(for: index)}
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool{
        return rules.contains{rule in rule.isSatisfied(for: index, record: record)}
    }
    
}
