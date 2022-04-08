//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 08.04.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class DateCacheTest: Ta4swiftTest {
    
    func test() {
        CacheTest.testUpdate(cache: DateCache())
    }
}
