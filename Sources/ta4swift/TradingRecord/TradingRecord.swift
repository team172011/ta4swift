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

public protocol TradingRecord {
    
}

public struct BaseTradingRecord: TradingRecord {
    
    public init() {
        
    }
}
