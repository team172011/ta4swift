//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 26.10.21.
//

import XCTest
@testable import ta4swift

final class BarSeriesTest: Ta4swiftTest {
    
    func testCreateBar() throws {
        let endTime = Date()
        let beginTime = endTime - 60
        let bar = createBar(10,12,9,11,1000,beginTime, endTime)
        XCTAssertTrue(bar.openPrice == 10)
        XCTAssertTrue(bar.closePrice == 11)
        XCTAssertTrue(bar.volume == 1000)
        XCTAssertTrue(bar.endTime == endTime)
        XCTAssertTrue(bar.beginTime == beginTime)
        XCTAssertTrue(bar.timePeriod == TimeInterval(60))
    }
    
    func testCreateBarSeries() throws {
        let now = Date();
        let bars = [createBar(10, now), createBar(11, now + 60)]
        let barSeries = BarSeries(name: "BarSeriesTest", bars: bars);
        barSeries.addBar(8, 10, 5, 4, 1000, now + 120)
        barSeries.addBar(4, 5, 4, 4, 100, now + 180)
        XCTAssertTrue(barSeries.name == "BarSeriesTest")
        XCTAssertTrue(barSeries.bars[0].beginTime == now)
        XCTAssertTrue(barSeries.bars[1].beginTime == now + 60)
        XCTAssertTrue(barSeries.bars[2].beginTime == now + 120)
        XCTAssertTrue(barSeries.bars[3].closePrice == 4)
    }
    
    func testBarSeriesIndicatorExtension() throws {
        let bars = createBars(10,11,12,10,12,13,11,10,9,8,9,10)
        let barSeries = BarSeries(name: "BarSeriesTest", bars: bars);
        
        let close = barSeries.close
        let high = barSeries.high
        let low = barSeries.low
        let open = barSeries.open
        let volume = barSeries.volume
        
        XCTAssertTrue(close.f(barSeries, 11) == bars[11].closePrice)
        XCTAssertTrue(close.f(barSeries, 0) == bars[0].closePrice)
        XCTAssertTrue(close.f(barSeries, 1) == bars[1].closePrice)
        
        XCTAssertTrue(high.f(barSeries, 11) == bars[11].highPrice)
        XCTAssertTrue(high.f(barSeries, 0) == bars[0].highPrice)
        XCTAssertTrue(high.f(barSeries, 1) == bars[1].highPrice)
        
        XCTAssertTrue(low.f(barSeries, 11) == bars[11].lowPrice)
        XCTAssertTrue(low.f(barSeries, 0) == bars[0].lowPrice)
        XCTAssertTrue(low.f(barSeries, 1) == bars[1].lowPrice)
        
        XCTAssertTrue(open.f(barSeries, 11) == bars[11].openPrice)
        XCTAssertTrue(open.f(barSeries, 0) == bars[0].openPrice)
        XCTAssertTrue(open.f(barSeries, 1) == bars[1].openPrice)
        
        XCTAssertTrue(volume.f(barSeries, 11) == Double(bars[11].volume))
        XCTAssertTrue(volume.f(barSeries, 0) == Double(bars[0].volume))
        XCTAssertTrue(volume.f(barSeries, 1) == Double(bars[1].volume))
    }
    
    func testCreateBarSeriesFromFile() throws{
        let appleBars = readAppleIncSeries("TestAppleInc")
        printValues(appleBars)
        let sma = appleBars.sma(barCount: 10)
        
        XCTAssertTrue(appleBars.name == "TestAppleInc")
        XCTAssertTrue(appleBars.bars.count == 252)
        printValues(appleBars, sma)
    }
    
    func testBarSeriesValueExtension() throws{
        let appleBars = readAppleIncSeries("TestAppleInc")
        let indicator = ConstantValueIndicator{ 10 }
        XCTAssertTrue(10 == appleBars.value(indicator, 10))

    }
    
}
