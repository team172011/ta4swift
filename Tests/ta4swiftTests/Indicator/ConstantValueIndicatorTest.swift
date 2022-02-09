import XCTest
@testable import ta4swift

final class ConstantValueIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let sma = ConstantValueIndicator{ 3.0 }
        
        XCTAssertTrue(sma.calc(barSeries, 17) == 3.0)
        XCTAssertTrue(sma.calc(barSeries, 0) == 3.0)
        XCTAssertTrue(sma.calc(barSeries, 1000) == 3.0)
    }
}
