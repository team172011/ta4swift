//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 23.01.22.
//

import Foundation

// returns true indicator1 crosses down indicator2/constant value
public struct CrossedIndicator: BooleanIndicator {
    public var cacheSize: Int = 0
    public var cached: Bool { get { false }}
    
    public var calc: (BarSeries, Int) -> Bool
    
    
    public init<T:ValueIndicator, U:ValueIndicator>(indicator1: T, indicator2: U) {
        self.calc = { barSeries, index in
            if index == 0 || indicator1.calc(barSeries, index) >= indicator2.calc(barSeries, index) {
                return false
            }
            
            var i = index - 1
            if indicator1.calc(barSeries, i) > indicator2.calc(barSeries, i) {
                return true
            }
            
            while i > 0 && indicator1.calc(barSeries, i) == indicator2.calc(barSeries, i) {
                i = i - 1
            }
            
            return ( i != 0) && indicator1.calc(barSeries, i) > indicator2.calc(barSeries, i)
        }
    }
    
    public init<T: ValueIndicator>(indicator1: T, constant: Double) {
        let indicator2 = ConstantValueIndicator{ constant }
        
        self.calc = { barSeries, index in
            if index == 0 || indicator1.calc(barSeries, index) >= indicator2.calc(barSeries, index) {
                return false
            }
            
            var i = index - 1
            if indicator1.calc(barSeries, i) > indicator2.calc(barSeries, i) {
                return true
            }
            
            while i > 0 && indicator1.calc(barSeries, i) == indicator2.calc(barSeries, i) {
                i = i - 1
            }
            
            return ( i != 0) && indicator1.calc(barSeries, i) > indicator2.calc(barSeries, i)
        }
    }
    
    public init<T: ValueIndicator>(constant: Double, indicator2: T) {
        let indicator1 = ConstantValueIndicator{ constant }
        
        self.calc = { barSeries, index in
            if index == 0 || indicator1.calc(barSeries, index) >= indicator2.calc(barSeries, index) {
                return false
            }
            
            var i = index - 1
            if indicator1.calc(barSeries, i) > indicator2.calc(barSeries, i) {
                return true
            }
            
            while i > 0 && indicator1.calc(barSeries, i) == indicator2.calc(barSeries, i) {
                i = i - 1
            }
            
            return ( i != 0) && indicator1.calc(barSeries, i) > indicator2.calc(barSeries, i)
        }
    }
}
