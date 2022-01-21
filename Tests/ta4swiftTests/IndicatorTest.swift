import XCTest
@testable import ta4swift


final class EMAIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let ema = EMAIndicator(indicator: close, barCount: 3)
        
        XCTAssertTrue(ema.getValue(for: 0) == 1, "EMA of index 0 should return first value of indicator base")
        XCTAssertTrue(ema.getValue(for: 17) == 17.00000762939453);
    }
}

final class SMAIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = ClosePriceIndicator(barSeries: barSeries)
        let sma = SMAIndicator(indicator: close, barCount: 3)
        printValues(sma)
        XCTAssertTrue(sma.getValue(for: 0) == 0, "SMA of index 0 should return 0")
        XCTAssertTrue(sma.getValue(for: 1) == 0, "SMA of index 1 should return 0")
        XCTAssertTrue(sma.getValue(for: 3) == 3)
        XCTAssertTrue(sma.getValue(for: 17) == 17);
    }
}

final class ConstantValueIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let sma = ConstantValueIndicator(barSeries: barSeries, constant: 3.0)
        
        XCTAssertTrue(sma.getValue(for: 17) == 3.0)
        XCTAssertTrue(sma.getValue(for: 0) == 3.0)
        XCTAssertTrue(sma.getValue(for: 1000) == 3.0)
    }
}

final class CrossIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,5,6,7,10,10,10,8,8,8,6)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let sma = CrossedIndicator(indicator: close, constant: 8.0)
        
        XCTAssertFalse(sma.getValue(for: 0))
        XCTAssertFalse(sma.getValue(for: 1))
        XCTAssertTrue(sma.getValue(for: 9))
        XCTAssertTrue(sma.getValue(for: 18))
    }
}
