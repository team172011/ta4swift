//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 08.04.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class SimpleCacheTest: Ta4swiftTest {
    
    func testUpdate() {
        CacheTest.testUpdate(cache: SimpleCache())
    }
}
