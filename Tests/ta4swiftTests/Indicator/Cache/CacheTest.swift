//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 08.04.22.
//

import Foundation
import XCTest

@testable import ta4swift

class CacheTest: Ta4swiftTest {
    
    static func testUpdate(cache: Cache) {
        let date = Date()
        let date2 = Date() - 1
        cache.update(for: date, with: 1)
        
        XCTAssertEqual(1, cache.getValue(for: date))
        
        cache.update(for: date, with: 2)
        
        XCTAssertEqual(2, cache.getValue(for: date))
        
        cache.update(for: date2, with: 3)
        
        XCTAssertEqual(2, cache.getValue(for: date))
        XCTAssertEqual(3, cache.getValue(for: date2))
        
        cache.update(for: date, with: 4)
        
        XCTAssertEqual(4, cache.getValue(for: date))
        XCTAssertEqual(3, cache.getValue(for: date2))
        XCTAssertEqual(2, cache.size)
        
        cache.clear()
        
        XCTAssertNil(cache.getValue(for: date))
        XCTAssertNil(cache.getValue(for: date2))
        XCTAssertEqual(0, cache.size)
    }
}
