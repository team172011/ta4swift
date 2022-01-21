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
    var date: Date
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
    
    func addBar(_ open: Double, _ high: Double, _ low: Double, _ close: Double, _ volume: Int, _ date: Date) {
        bars.append(Bar(openPrice: open, highPrice: high, lowPrice: low, closePrice: close, volume: volume, date: date))
    }
}

extension BarSeries {
    
    public var close: ClosePriceIndicator {
        get {
            return ClosePriceIndicator(barSeries: self)
        }
    }
    
    public var high: HighPriceIndicator {
        get {
            return HighPriceIndicator(barSeries: self)
        }
    }
    
    public var low: LowPriceIndicator {
        get {
            return LowPriceIndicator(barSeries: self)
        }
    }
    
    public var open: OpenPriceIndicator {
        get {
            return OpenPriceIndicator(barSeries: self)
        }
    }
    
    public var volume: VolumePriceIndicator {
        get {
            return VolumePriceIndicator(barSeries: self)
        }
    }

}

