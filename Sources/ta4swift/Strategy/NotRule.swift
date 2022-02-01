//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 01.02.22.
//

import Foundation

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
