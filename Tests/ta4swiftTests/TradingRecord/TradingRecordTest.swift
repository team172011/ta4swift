//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation
import XCTest

@testable import ta4swift

final public class TradingRecordTest: Ta4swiftTest {
    
    public func testTradingRecord() {
        let tradeA = BaseTrade(type: .BUY, index: 1)
        let tradeB = BaseTrade(type: .SELL, index: 3)
        
        var record = BaseTradingRecord()
        XCTAssertFalse(record.hasOpenPosition)
        
        try! record.addPosition(with: tradeA)
        XCTAssertTrue(record.hasOpenPosition)
        
        try! record.closePosition(with: tradeB)
        XCTAssertFalse(record.hasOpenPosition)
        
        XCTAssertTrue(record.positions.count == 1)
    }
}
