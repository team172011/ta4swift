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
    
    func shouldEnter(index: Int, record: TradingRecord) -> Bool
    func shouldExit(index: Int, record: TradingRecord) -> Bool
    
    func canEnter(record: TradingRecord) -> Bool
    func canExit(record: TradingRecord) -> Bool
    
}
