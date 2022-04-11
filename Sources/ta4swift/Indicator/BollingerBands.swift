//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 16.02.22.
//

import Foundation
import CoreData

public class BollingerBands {
    
    let base: ValueIndicator
    
    let lower: ValueIndicator
    let middle: ValueIndicator
    let upper: ValueIndicator
    let percentB: ValueIndicator
    /**
    Creates bollinger bands indicators based on the close price for given bar count and multiplier
     */
    public convenience init(barCount: Int, multiplier: Double) {
        self.init(base: ClosePriceIndicator(), barCount: barCount, multiplier: multiplier)
    }
    
    /**
    Creates bollinger bands indicators based on the given indicator,  bar count and multiplier
     */
    public convenience init(base: ValueIndicator, barCount: Int, multiplier: Double) {
        let stdev = StandardDeviationIndicator(barCount: barCount){ base }
        let middle = SMAIndicator(barCount: barCount) { base }
        let upper = middle.plus(stdev.multiply(multiplier))
        let lower = middle.minus(stdev.multiply(multiplier))
        self.init(base: base, lower: lower, middle: middle, upper: upper)
    }
    
    public init(base: ValueIndicator, lower: ValueIndicator, middle: ValueIndicator, upper: ValueIndicator) {
        self.base = base
        self.middle = middle
        self.upper = upper
        self.lower = lower
        self.percentB = base.minus(lower).divide(upper.minus(lower))
    }
}
