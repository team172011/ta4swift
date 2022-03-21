//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 21.03.22.
//

import Foundation
import XCTest
@testable import ta4swift

public final class ExtensionTest: Ta4swiftTest {
    
    public func testArrayInsertionIndexOfExtension() {
        
        let list = [Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000)), Date().addingTimeInterval(Double.random(in: 0...100000))]

        var sortedList = [Date]()

        for i in list {
            sortedList.insert(i, at: sortedList.insertionIndexOf(i){ a, b in a < b })
        }

        for (idx, date) in sortedList.enumerated() {
            if idx > 0 {
                XCTAssertTrue(date > sortedList[idx-1])
            }
        }
    }
    
    public func testDateMinusExtension() {
        
        let dateA = Date();
        let dateB = dateA.addingTimeInterval(1000)
        
        let diff = dateB - dateA
        let diff2 = dateA - dateB
        
        XCTAssertEqual(diff, 1000)
        XCTAssertEqual(diff2, -1000)
    }
    
    public func testDoubleExtension() {
        let n = 1.0
        
        let max = n.max(20)
        let min = n.min(20)
        
        let abs = n.abs()
        let abs2 = (n * -1.0).abs()
        
        XCTAssertEqual(max, 20.0)
        XCTAssertEqual(min, 1.0)
        XCTAssertEqual(abs, 1.0)
        XCTAssertEqual(abs2, 1.0)
    }
    
    public func testIntExtension() {
        let n = 1
        
        let max = n.max(20)
        let min = n.min(20)
        
        let abs = n.abs()
        let abs2 = (n * -1).abs()
        
        XCTAssertEqual(max, 20)
        XCTAssertEqual(min, 1)
        XCTAssertEqual(abs, 1)
        XCTAssertEqual(abs2, 1)
    }
}
