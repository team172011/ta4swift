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
        assert(bar.openPrice == 10)
        assert(bar.closePrice == 11)
        assert(bar.volume == 1000)
        assert(bar.date == now)
    }
    
    func testCreateBarSeries() throws {
        let now = Date();
        let bars = [createBar(10, now), createBar(11, now + 60)]
        let barSeries = BarSeries(name: "BarSeriesTest", bars: bars);
        barSeries.addBar(8, 10, 5, 4, 1000, now + 120)
        barSeries.addBar(4, 5, 4, 4, 100, now + 180)
        assert(barSeries.name == "BarSeriesTest")
        assert(barSeries.bars[0].date == now)
        assert(barSeries.bars[1].date == now + 60)
        assert(barSeries.bars[2].date == now + 120)
        assert(barSeries.bars[3].closePrice == 4)
    }
    
    func testBarSeriesIndicatorExtension() throws {
        let bars = createBars(10,11,12,10,12,13,11,10,9,8,9,10)
        let barSeries = BarSeries(name: "BarSeriesTest", bars: bars);
        
        let close = barSeries.close
        let high = barSeries.high
        let low = barSeries.low
        let open = barSeries.open
        let volume = barSeries.volume
        
        assert(close.getValue(for: 11) == bars[11].closePrice)
        assert(close.getValue(for: 0) == bars[0].closePrice)
        assert(close.getValue(for: 1) == bars[1].closePrice)
        
        assert(high.getValue(for: 11) == bars[11].highPrice)
        assert(high.getValue(for: 0) == bars[0].highPrice)
        assert(high.getValue(for: 1) == bars[1].highPrice)
        
        assert(low.getValue(for: 11) == bars[11].lowPrice)
        assert(low.getValue(for: 0) == bars[0].lowPrice)
        assert(low.getValue(for: 1) == bars[1].lowPrice)
        
        assert(open.getValue(for: 11) == bars[11].openPrice)
        assert(open.getValue(for: 0) == bars[0].openPrice)
        assert(open.getValue(for: 1) == bars[1].openPrice)
        
        assert(volume.getValue(for: 11) == Double(bars[11].volume))
        assert(volume.getValue(for: 0) == Double(bars[0].volume))
        assert(volume.getValue(for: 1) == Double(bars[1].volume))
    
    }
    
}
