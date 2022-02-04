//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct ConstantValueIndicator: ValueIndicator {
    public var f: (BarSeries, Int) -> Double
    
    public init(_ value: () -> Double) {
        let v = value()
        self.f = { barSeries, index in return v }
    }
}
