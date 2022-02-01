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
            if strategy.shouldEnter(index: i, record: record) {
                if strategy.canEnter(record: record) {
                    try! record.addPosition(with: BaseTrade(type: type, index: i))
                }
            } else if strategy.shouldExit(index: i, record: record) {
                if strategy.canExit(record: record) {
                    try! record.closePosition(with: BaseTrade(type: type.opposite, index: i))
                }
            }
        }
        
        return record
    }
}
