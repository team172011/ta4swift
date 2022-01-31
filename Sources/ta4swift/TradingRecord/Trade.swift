//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public enum TradeType {
    case BUY
    case SELL
}

public protocol Trade {
    var type: TradeType { get }
    var index: Int { get }
}

public extension Trade {
    
    var opposite: TradeType {
        get {
            if self.type == TradeType.SELL {
                return TradeType.BUY
            }
            return TradeType.SELL
        }
    }
}

public struct BaseTrade: Trade {
    public let type: TradeType
    public let index: Int
    
}
