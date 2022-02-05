//
//  BarSeries.swift
//  
//
//

import Foundation

/**
 A bar is representing financial data like open, high, low, close prices and volume at a specific date
 */
public struct Bar {
    
    var openPrice: Double
    var highPrice: Double
    var lowPrice: Double
    var closePrice: Double
    var volume: Int
    var beginTime: Date
    var trades: Int?
    var amount: Double?
    var endTime: Date?
    var timePeriod: TimeInterval? {
        endTime?.timeIntervalSince(beginTime)
    }
}

/**
 A bar series is representing a set of bars and should have an name as identifier
 */
public class BarSeries {
    
    let name: String
    var bars = [Bar]()
    
    public init(name: String, bars: [Bar]) {
        self.name = name;
        self.bars = bars;
    }
    
    init(name: String) {
        self.name = name;
    }
    
}

extension BarSeries {
    
    func addBar(_ open: Double, _ high: Double, _ low: Double, _ close: Double, _ volume: Int, _ beginTime: Date) {
        addBar(open, high, low, close, volume, beginTime, nil, nil, nil)
    }
    
    func addBar(_ open: Double, _ high: Double, _ low: Double, _ close: Double, _ volume: Int, _ beginTime: Date, _ trades: Int?, _ amount: Double?,  _ endTime: Date?) {
        bars.append(Bar(openPrice: open, highPrice: high, lowPrice: low, closePrice: close, volume: volume, beginTime: beginTime, trades: trades, amount: amount, endTime: endTime))
    }
}

/**
 Extension for basic indicators providing ohlcv values
 */
extension BarSeries {
    
    public var close: NumericIndicator {
        get {
            return NumericIndicator{ ClosePriceIndicator() }
        }
    }
                                                         
    
    public var high: NumericIndicator {
        get {
            return NumericIndicator{ HighPriceIndicator() }
        }
    }
                                                         
    public var low: NumericIndicator {
        get {
            return NumericIndicator{ LowPriceIndicator()}
        }
    }
    
    
    public var open: NumericIndicator {
        get {
            return NumericIndicator{ OpenPriceIndicator() }
        }
    }
    
    
    public var volume: NumericIndicator {
        get {
            return NumericIndicator{ VolumePriceIndicator() }
        }
    }
    
}
                                                         

/**
 Extension for frequently used indicators like SMA or EMAIndicaor based on the close price
 */
extension BarSeries {
    
    public func sma(barCount: Int) -> SMAIndicator {
        return SMAIndicator(indicator: self.close, barCount: barCount)
    }
    
    public func ema(barCount: Int) -> EMAIndicator {
        return EMAIndicator(indicator: self.close, barCount: barCount)
    }
    
    public func value<T: ValueIndicator>(_ indicator: T, _ index: Int) -> Double {
        return indicator.f(self, index)
    }
}
