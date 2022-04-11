//
//  ClosePriceIndicator.swift
//  
//
//  Created by Simon-Justus Wimmer on 09.02.22.
//

import Foundation

public struct ClosePriceIndicator: ValueIndicator {
    public var cached: Bool { get { false }}
    public var calc: (BarSeries, Int) -> Double = {$0.bars[$1].closePrice}
}

public struct OpenPriceIndicator: ValueIndicator {
    public var cached: Bool = false
    public var calc: (BarSeries, Int) -> Double = {$0.bars[$1].openPrice}
}

public struct HighPriceIndicator: ValueIndicator {
    public var cached: Bool = false
    public var calc: (BarSeries, Int) -> Double = {$0.bars[$1].highPrice}
}

public struct LowPriceIndicator: ValueIndicator {
    public var cached: Bool = false
    public var calc: (BarSeries, Int) -> Double = {$0.bars[$1].lowPrice}
}

public struct VolumePriceIndicator: ValueIndicator {
    public var cached: Bool = false
    public var calc: (BarSeries, Int) -> Double = {Double($0.bars[$1].volume)}
}
