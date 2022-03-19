//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 16.02.22.
//

import Foundation
import CoreData

public class BollingerBands<MIDDLE: ValueIndicator,
    UPPER: ValueIndicator,LOWER: ValueIndicator,
    BASE: ValueIndicator, PERCENTB: ValueIndicator>{
    
    let base: BASE
    
    let lower: LOWER
    let middle: MIDDLE
    let upper: UPPER
    let percentB: PERCENTB
    /**
    Creates bollinger bands indicators based on the close price for given bar count and multiplier
     */
    public convenience init(barCount: Int, multiplier: Double) where BASE == ClosePriceIndicator, MIDDLE == SMAIndicator, UPPER == RawIndicator, LOWER == RawIndicator, PERCENTB == RawIndicator {
        self.init(base: ClosePriceIndicator(), barCount: barCount, multiplier: multiplier)
    }
    
    /**
    Creates bollinger bands indicators based on the given indicator,  bar count and multiplier
     */
    public convenience init(base: BASE, barCount: Int, multiplier: Double) where MIDDLE == SMAIndicator, UPPER == RawIndicator, LOWER == RawIndicator, PERCENTB == RawIndicator {
        let stdev = StandardDeviationIndicator(barCount: barCount){ base }
        let middle = SMAIndicator(barCount: barCount) { base }
        let upper = middle.plus(stdev.multiply(multiplier))
        let lower = middle.minus(stdev.multiply(multiplier))
        self.init(base: base, lower: lower, middle: middle, upper: upper)
    }
    
    public init(base: BASE, lower: LOWER, middle: MIDDLE, upper: UPPER) where MIDDLE == SMAIndicator, PERCENTB == RawIndicator{
        self.base = base
        self.middle = middle
        self.upper = upper
        self.lower = lower
        self.percentB = base.minus(lower).divide(upper.minus(lower))
    }
}
