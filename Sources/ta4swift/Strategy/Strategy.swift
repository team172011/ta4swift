//
//  File.swift
//  
//
//

import Foundation


public protocol Strategy {
    
    var entryRule: Rule { get }
    var exitRule: Rule { get }
    var unstablePeriod: Int { get set }
    
    func isUnstableAt(index: Int) -> Bool
    
    func shouldEnter(_ barSeries: BarSeries, index: Int, record: TradingRecord) -> Bool
    func shouldExit(_ barSeries: BarSeries, index: Int, record: TradingRecord) -> Bool
    
    func canEnter(_ barSeries: BarSeries, record: TradingRecord) -> Bool
    func canExit(_ barSeries: BarSeries, record: TradingRecord) -> Bool
    
}
