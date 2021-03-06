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
    
    public init(_ rules: () -> (Rule, Rule)) {
        let r = rules()
        self.rule1 = r.0
        self.rule2 = r.1
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int) -> Bool{
        return rule1.isSatisfied(barSeries, for: index) ^ rule2.isSatisfied(barSeries, for: index)
    }
    
    public func isSatisfied(_ barSeries: BarSeries, for index: Int, record: TradingRecord) -> Bool{
        return rule1.isSatisfied(barSeries, for: index, record: record) ^ rule2.isSatisfied(barSeries, for: index, record: record)
    }
    
}


extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}
