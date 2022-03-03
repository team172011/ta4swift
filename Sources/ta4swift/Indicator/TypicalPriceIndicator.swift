//
//  File 2.swift
//  
//
//  Created by Simon-Justus Wimmer on 03.03.22.
//

import Foundation
public struct TypicalPriceIndicator: ValueIndicator {
    public var calc: calcFuncTypeValue
    
    
    public init() {
        self.calc = { barSeries, index in
            let bar = barSeries.bars[index]
            
            return (bar.highPrice + bar.lowPrice + bar.closePrice) / 3
        }
    }
}
