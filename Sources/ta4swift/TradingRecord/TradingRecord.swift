//
//  TradingRecord.swift
//  
//
//

import Foundation

public protocol TradingRecord {
    
    var positions: [Position] { get }
    mutating func addPosition(_ position: Position)
    mutating func addPosition(with trade: Trade) throws
    mutating func closePosition(with trade: Trade) throws

}

public extension TradingRecord {
    
    var hasOpenPosition: Bool {
        get {
            if let lastPos = self.positions.last {
                return lastPos.isOpen
            }
            return false
        }
    }
}

public struct BaseTradingRecord: TradingRecord {
    
    public var positions: [Position]
    
    public init() {
        positions = [BasePosition]()
    }
    
    public mutating func addPosition(with trade: Trade) throws {
        if !hasOpenPosition {
            positions.append(BasePosition(entry: trade))
        } else {
            throw OpenPositionError()
        }
    }
    
    public mutating func closePosition(with trade: Trade) throws {
        if hasOpenPosition {
            positions[positions.count - 1].exit = trade
        } else {
            throw NoOpenPositionError()
        }
    }
    
    public mutating func addPosition(_ position: Position) {
        self.positions.append(position)
    }
}

public struct NoOpenPositionError: Error {
    
}

public struct OpenPositionError: Error {

}
