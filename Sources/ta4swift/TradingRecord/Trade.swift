//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation
import CloudKit

public enum TradeType {
    case buy
    case sell
}

public protocol Trade: CustomStringConvertible{
    var type: TradeType { get }
    var index: Int { get }
}

public extension TradeType {
    
    var opposite: TradeType {
        get {
            if self == TradeType.sell {
                return TradeType.buy
            }
            return TradeType.sell
        }
    }
}

public struct BaseTrade: Trade, CustomStringConvertible {
    public let type: TradeType
    public let index: Int
    
    public var description: String {
        return "\(type) at: \(index)"
    }
    
}
