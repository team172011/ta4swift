//
//  KeltnerChannel.swift
//  
//
//  Created by Simon-Justus Wimmer on 03.03.22.
//

import Foundation

public class KeltnerChannel {
    
    
    var middle: ValueIndicator
    
    var lower: ValueIndicator
    
    var upper: ValueIndicator
    /**
    Creates KeltnerChennels with the given parameters
        - emaBarCount:   the bar count for the (middle) EmaIndicator
        - atrBarCount:      the bar count for the ATRIndicator used for upper and lower channel line
        - k:                        the multiplier for the upper and lower channel line
     */
    public init(emaBarCount: Int, atrBarCount: Int, k: Double) {
        let price = ClosePriceIndicator();
        let atr = ATRIndicator(barCount: atrBarCount);
        
        self.middle = EMAIndicator(barCount: emaBarCount) { price }
        self.upper = middle.plus(atr.multiply(k))
        self.lower = middle.minus(atr.multiply(k))
        
        
    }
    
    func lowerIndicator() {
        
    }
    
}
