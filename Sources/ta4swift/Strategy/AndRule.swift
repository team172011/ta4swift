//
//  File 5.swift
//  
//
//  Created by Simon-Justus Wimmer on 01.02.22.
//

import Foundation

public struct AndRule: Rule {
    
    public let rules: [Rule]
    
    public init(_ rules: () -> [Rule]) {
        self.rules = rules()
    }
    
    public func isSatisfied(for index: Int) -> Bool {
        return rules.allSatisfy{ rule in rule.isSatisfied(for: index)}
    }
    
    public func isSatisfied(for index: Int, record: TradingRecord) -> Bool {
        return rules.allSatisfy{ rule in rule.isSatisfied(for: index, record: record)}
    }
}
