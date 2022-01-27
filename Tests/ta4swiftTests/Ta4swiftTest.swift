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
    
    func readAppleIncSeries(_ name: String) -> BarSeries {
        let data = readFileAsStringArray(fileName: "appleinc_bars")
        var bars = [Bar]()
        for row in data {
            let entries = row.components(separatedBy: ",")
            if(entries.count >= 5) {
                bars.append(createBar(Double(entries[1])!, Double(entries[2])!, Double(entries[3])!, Double(entries[4])!, Int(entries[5])!, Date()))
            }

        }
        return BarSeries(name: name, bars: bars)

    }
    
    func readFileAsStringArray(fileName: String) -> [String]  {
        if let filePath = Bundle.module.path(forResource: fileName, ofType: "csv"){
            do {
                let contents = try String(contentsOfFile: filePath)
                return contents.components(separatedBy: "\n")
            } catch {
                return [String]()
            }
        } else {
            print("no file or content found!")
            return [String]()
        }
    }
    
    func createBars(_ closePrices: Double...) -> [Bar] {
        var bars = [Bar]()
        let now = Date()
        for (index, price) in closePrices.enumerated() {
            bars.append(createBar(price, now + TimeInterval((index * 60))))
        }
        return bars
    }
    
    func createBar(_ close: Double, _ date: Date) -> Bar {
        let high = Double.random(in: close...close*2)
        let low = Double.random(in: close*0.5...close)
        let open = Double.random(in: low...high)
        let volume = Int.random(in: 1...100000)
        return createBar(open, high, low, close, volume, date)
    }
    
    func createBar(_ open: Double, _ high: Double, _ low: Double, _ close: Double, _ volume: Int, _ date: Date) -> Bar {
        let beginTime = date.addingTimeInterval(TimeInterval(Int.random(in: -28800...(-60))))
        let endTime = date
        return createBar(open, high, low, close, volume, beginTime, endTime)
    }
    
    func createBar(_ open: Double, _ high: Double, _ low: Double, _ close: Double, _ volume: Int, _ beginTime: Date, _ endTime: Date) -> Bar {
        let trades = Int.random(in: 1...5000)
        let amount = Double.random(in: 10_000...100_000)
        return Bar(openPrice: open, highPrice: high, lowPrice: low, closePrice: close, volume: volume, trades: trades, amount: amount, beginTime: beginTime, endTime: endTime)
    }
    
}

/**
 Debug helper methods for the ta4j testing framework
 */
extension Ta4swiftTest {
    
    /**
        Prints all values of this BooleanIndicator on the console if executed in xCode
     */
    func printValues(_ indicator: BooleanIndicator) {
        #if Xcode
        for (i, _) in indicator.barSeries.bars.enumerated() {
            print("index: \(i) value: \(indicator.getValue(for: i))")
        }
        #endif
    }
    
    /**
        Prints all values  of this ValueIndicator on the console if executed in xCode
     */
    func printValues(_ indicator: ValueIndicator) {
        #if Xcode
        for (i, _) in indicator.barSeries.bars.enumerated() {
            print("index: \(i) value: \(indicator.getValue(for: i))")
        }
        #endif
    }
    
    /**
        Prints all values of this Rule on the console if executed in xCode
     */
    func printValues(_ rule: Rule, _ barSeries: BarSeries) {
        #if Xcode
        for (i, _) in barSeries.bars.enumerated() {
            print("index: \(i) value: \(rule.isSatisfied(for: i))")
        }
        #endif
    }
    
    /**
        Prints all values of this BarSeries on the console if executed in xCode
     */
    func printValues(_ barSeries: BarSeries) {
        #if Xcode
        for (i, b) in barSeries.bars.enumerated() {
            print("index: \(i) value: \(b)")
        }
        #endif
    }
}
