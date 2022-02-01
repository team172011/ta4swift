//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

import XCTest

@testable import ta4swift

final class PositionTest: Ta4swiftTest {
    
    func testPosition() throws {
        var position = BasePosition()
        XCTAssertFalse(position.isOpen)
        
        position.entry = BaseTrade(type: TradeType.buy, index: 2)
        XCTAssertTrue(position.isOpen)
        
        position.exit  = BaseTrade(type: TradeType.sell, index: 3)
        XCTAssertFalse(position.isOpen)
    }
}
