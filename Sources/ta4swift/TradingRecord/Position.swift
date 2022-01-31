//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public protocol Position {
    var entry: Trade? { get set }
    var exit: Trade? { get set }
}

public extension Position {
    var isOpen: Bool {
        get {
            return entry != nil && exit == nil
        }
    }
}

public struct BasePosition: Position {
    public var entry: Trade?
    public var exit: Trade?
    
    public init() {}
    
    public init(entry: Trade) {
        self.entry = entry
    }
}
