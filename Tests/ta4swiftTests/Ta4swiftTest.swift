//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 16.01.22.
//

@testable import ta4swift
import Foundation
import XCTest

public class Ta4swiftTest: XCTestCase {
    
    func createBars(_ closePrices: Double...) -> [Bar] {
        var bars = [Bar]()
        let now = Date()
        for (index, price) in closePrices.enumerated() {
            bars.append(createBar(price, now + TimeInterval((index * 60))))
        }
        return bars
    }
    
    func createBar(_ open: Double, _ high: Double, _ low: Double, _ close: Double, _ volume: Int, _ date: Date) -> Bar {
        return Bar(openPrice: open, highPrice: high, lowPrice: low, closePrice: close, volume: volume, date: date)
    }
    
    func createBar(_ close: Double, _ date: Date) -> Bar {
        let high = Double.random(in: close...close*2)
        let low = Double.random(in: close*0.5...close)
        let open = Double.random(in: low...high)
        let volume = Int.random(in: 1...100000)
        return Bar(openPrice: open, highPrice: high, lowPrice: low, closePrice: close, volume: volume, date: date)
    }
    
}

/**
 Debug helper methods for the ta4j testing framework
 */
extension Ta4swiftTest {
    
    func printValues(_ indicator: BooleanIndicator) {
        #if Xcode
        for (i, _) in indicator.barSeries.bars.enumerated() {
            print("index: \(i) value: \(indicator.getValue(for: i))")
        }
        #endif
    }
    
    func printValues(_ indicator: ValueIndicator) {
        #if Xcode
        for (i, _) in indicator.barSeries.bars.enumerated() {
            print("index: \(i) value: \(indicator.getValue(for: i))")
        }
        #endif
    }
    
    func printValues(_ rule: Rule, _ barSeries: BarSeries) {
        #if Xcode
        for (i, _) in barSeries.bars.enumerated() {
            print("index: \(i) value: \(rule.isSatisfied(for: i))")
        }
        #endif
    }
}
