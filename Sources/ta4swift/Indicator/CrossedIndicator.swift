//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 23.01.22.
//

import Foundation

// returns true indicator1 crosses down indicator2/constant value
public struct CrossedIndicator: BooleanIndicator {
    
    public var f: (BarSeries, Int) -> Bool
    
    
    public init(indicator1: ValueIndicator, indicator2: ValueIndicator) {
        self.f = { barSeries, index in
            if index == 0 || indicator1.f(barSeries, index) >= indicator2.f(barSeries, index) {
                return false
            }
            
            var i = index - 1
            if indicator1.f(barSeries, i) > indicator2.f(barSeries, i) {
                return true
            }
            
            while i > 0 && indicator1.f(barSeries, i) == indicator2.f(barSeries, i) {
                i = i - 1
            }
            
            return ( i != 0) && indicator1.f(barSeries, i) > indicator2.f(barSeries, i)
        }
    }
    
    public init(indicator1: ValueIndicator, constant: Double) {
        let indicator2 = ConstantValueIndicator{ constant }
        
        self.f = { barSeries, index in
            if index == 0 || indicator1.f(barSeries, index) >= indicator2.f(barSeries, index) {
                return false
            }
            
            var i = index - 1
            if indicator1.f(barSeries, i) > indicator2.f(barSeries, i) {
                return true
            }
            
            while i > 0 && indicator1.f(barSeries, i) == indicator2.f(barSeries, i) {
                i = i - 1
            }
            
            return ( i != 0) && indicator1.f(barSeries, i) > indicator2.f(barSeries, i)
        }
    }
    
    public init(constant: Double, indicator2: ValueIndicator) {
        let indicator1 = ConstantValueIndicator{ constant }
        
        self.f = { barSeries, index in
            if index == 0 || indicator1.f(barSeries, index) >= indicator2.f(barSeries, index) {
                return false
            }
            
            var i = index - 1
            if indicator1.f(barSeries, i) > indicator2.f(barSeries, i) {
                return true
            }
            
            while i > 0 && indicator1.f(barSeries, i) == indicator2.f(barSeries, i) {
                i = i - 1
            }
            
            return ( i != 0) && indicator1.f(barSeries, i) > indicator2.f(barSeries, i)
        }
    }
}
