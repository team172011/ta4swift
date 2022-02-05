//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct Runner {
    
    static func run(barSeries: BarSeries, strategy: Strategy, type: TradeType) -> TradingRecord {
        var record = BaseTradingRecord();
        
        for (i,_) in barSeries.bars.enumerated() {
            if strategy.shouldEnter(barSeries, index: i, record: record) {
                if strategy.canEnter(barSeries, record: record) {
                    try! record.addPosition(with: BaseTrade(type: type, index: i))
                }
            } else if strategy.shouldExit(barSeries, index: i, record: record) {
                if strategy.canExit(barSeries, record: record) {
                    try! record.closePosition(with: BaseTrade(type: type.opposite, index: i))
                }
            }
        }
        
        return record
    }
    
    static func run(barSeries: [BarSeries], strategy: Strategy, type: TradeType) -> Dictionary<String, TradingRecord> {
        var records = Dictionary<String, TradingRecord>()
        for series in barSeries {
            let result = run(barSeries: series, strategy: strategy, type: type)
            records[series.name] = result
        }
        
        return records
    }
}
