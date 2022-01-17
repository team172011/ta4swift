import XCTest
@testable import ta4swift


final class EMAIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let ema = EMAIndicator(indicator: close, barCount: 3)
        
        assert(ema.getValue(for: 0) == 1, "EMA of index 0 should return first value of indicator base")
        assert(ema.getValue(for: 17) == 17.00000762939453);
    }
}

final class SMAIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let sma = SMAIndicator(indicator: close, barCount: 3)
        
        for (i, _) in bars.enumerated() {
            print(sma.getValue(for: i))
        }
        assert(sma.getValue(for: 0) == 0, "SMA of index 0 should return first value of indicator base")
        assert(sma.getValue(for: 17) == 17.00000762939453);
    }
}
