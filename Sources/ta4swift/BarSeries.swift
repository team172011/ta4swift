//
//  BarSeries.swift
//  
//
//

import Foundation

struct Bar {
    
    var openPrice: Double
    var highPrice: Double
    var lowPrice: Double
    var closePrice: Double
    var volume: Int
    var date: Date
}

public class BarSeries {
    
    let name: String
    var bars = [Bar]()
    
    init(name: String, bars: [Bar]) {
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
    
    var close: ClosePriceIndicator {
        get {
            return ClosePriceIndicator(barSeries: self)
        }
    }
    
    var high: HighPriceIndicator {
        get {
            return HighPriceIndicator(barSeries: self)
        }
    }
    
    var low: LowPriceIndicator {
        get {
            return LowPriceIndicator(barSeries: self)
        }
    }
    
    var open: OpenPriceIndicator {
        get {
            return OpenPriceIndicator(barSeries: self)
        }
    }
    
    var volume: VolumePriceIndicator {
        get {
            return VolumePriceIndicator(barSeries: self)
        }
    }

}

