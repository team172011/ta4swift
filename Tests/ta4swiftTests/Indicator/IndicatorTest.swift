import XCTest
@testable import ta4swift

final class ConstantValueIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let sma = ConstantValueIndicator{ 3.0 }
        
        XCTAssertTrue(sma.f(barSeries, 17) == 3.0)
        XCTAssertTrue(sma.f(barSeries, 0) == 3.0)
        XCTAssertTrue(sma.f(barSeries, 1000) == 3.0)
    }
}

final class CrossIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,5,6,7,10,10,10,8,8,8,6)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let sma = CrossedIndicator(indicator1: close, constant: 8)
        
        XCTAssertFalse(sma.f(barSeries, 0))
        XCTAssertFalse(sma.f(barSeries, 1))
        XCTAssertTrue(sma.f(barSeries, 9))
        XCTAssertTrue(sma.f(barSeries, 18))
    }
}
