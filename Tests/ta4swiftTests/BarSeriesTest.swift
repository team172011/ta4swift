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
        let now = Date();
        let bar = createBar(10,12,9,11,1000,now)
        XCTAssertTrue(bar.openPrice == 10)
        XCTAssertTrue(bar.closePrice == 11)
        XCTAssertTrue(bar.volume == 1000)
        XCTAssertTrue(bar.date == now)
    }
    
    func testCreateBarSeries() throws {
        let now = Date();
        let bars = [createBar(10, now), createBar(11, now + 60)]
        let barSeries = BarSeries(name: "BarSeriesTest", bars: bars);
        barSeries.addBar(8, 10, 5, 4, 1000, now + 120)
        barSeries.addBar(4, 5, 4, 4, 100, now + 180)
        XCTAssertTrue(barSeries.name == "BarSeriesTest")
        XCTAssertTrue(barSeries.bars[0].date == now)
        XCTAssertTrue(barSeries.bars[1].date == now + 60)
        XCTAssertTrue(barSeries.bars[2].date == now + 120)
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
        
        XCTAssertTrue(close.getValue(for: 11) == bars[11].closePrice)
        XCTAssertTrue(close.getValue(for: 0) == bars[0].closePrice)
        XCTAssertTrue(close.getValue(for: 1) == bars[1].closePrice)
        
        XCTAssertTrue(high.getValue(for: 11) == bars[11].highPrice)
        XCTAssertTrue(high.getValue(for: 0) == bars[0].highPrice)
        XCTAssertTrue(high.getValue(for: 1) == bars[1].highPrice)
        
        XCTAssertTrue(low.getValue(for: 11) == bars[11].lowPrice)
        XCTAssertTrue(low.getValue(for: 0) == bars[0].lowPrice)
        XCTAssertTrue(low.getValue(for: 1) == bars[1].lowPrice)
        
        XCTAssertTrue(open.getValue(for: 11) == bars[11].openPrice)
        XCTAssertTrue(open.getValue(for: 0) == bars[0].openPrice)
        XCTAssertTrue(open.getValue(for: 1) == bars[1].openPrice)
        
        XCTAssertTrue(volume.getValue(for: 11) == Double(bars[11].volume))
        XCTAssertTrue(volume.getValue(for: 0) == Double(bars[0].volume))
        XCTAssertTrue(volume.getValue(for: 1) == Double(bars[1].volume))
    
    }
    
}
