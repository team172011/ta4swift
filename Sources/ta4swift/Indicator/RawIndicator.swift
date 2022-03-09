//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 09.02.22.
//

/**
 A Raw Indicator is the simplest represenation of an indicator. It can be instantiated by providing a
 calc function or an operation type
 */
public struct RawIndicator: ValueIndicator {
    
    public var calc: calcFuncTypeValue
    
    /**
     Creates a RawIndicator with the provided formular.
     */
    public init( _ formular: @escaping () -> calcFuncTypeValue) {
        self.calc = formular()
    }
    
    public init(_ operation: @escaping () -> BinaryOperation){
        self.init{operation().calc}
    }
    
    public init(_ operation: @escaping () -> UnaryOperation){
        self.init{operation().calc}
    }
}
