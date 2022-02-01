//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation
@testable import ta4swift
import XCTest

final class TradeTest: Ta4swiftTest {
    
    func testTrade() throws {
        let trade = BaseTrade(type: TradeType.sell, index: 2)
        XCTAssertEqual(trade.type.opposite, TradeType.buy)
    }
}
