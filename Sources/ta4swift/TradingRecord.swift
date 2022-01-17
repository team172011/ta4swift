//
//  TradingRecord.swift
//  
//
//

import Foundation


public enum TradeType {
    case BUY
    case SELL
}

public struct Runner {
    
    func run(strategy: Strategy, type: TradeType) -> TradingRecord {
        let record = BaseTradingRecord();
        
        return record
    }
}
public protocol TradingRecord {
    
}

public struct BaseTradingRecord: TradingRecord {
    
}

public struct Trade {
    let type: TradeType
    let index: Int
}

public struct Position {
    var entry: Trade
    var exit: Trade
}
