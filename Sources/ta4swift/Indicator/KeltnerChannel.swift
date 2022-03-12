//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 03.03.22.
//

import Foundation

public class KeltnerChannel<MIDDLE: ValueIndicator,
    UPPER: ValueIndicator,LOWER: ValueIndicator>{
    
    let lower: LOWER
    let middle: MIDDLE
    let upper: UPPER
    /**
    Creates KeltnerChennels with the given parameters
        - emaBarCount:   the bar count for the (middle) EmaIndicator
        - atrBarCount:      the bar count for the ATRIndicator used for upper and lower channel line
        - k:                        the multiplier for the upper and lower channel line
     */
    public init(emaBarCount: Int, atrBarCount: Int, k: Double) where MIDDLE == EMAIndicator, UPPER == RawIndicator, LOWER == RawIndicator {
        let price = ClosePriceIndicator();
        let atr = ATRIndicator(barCount: atrBarCount);
        
        self.middle = EMAIndicator(barCount: emaBarCount) { price }
        self.upper = middle.plus(atr.multiply(k))
        self.lower = middle.minus(atr.multiply(k))
    }
    
}
