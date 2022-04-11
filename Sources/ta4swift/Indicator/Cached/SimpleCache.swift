//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 09.03.22.
//

import Foundation
import Logging
import LRUCache

/**
 A simple cache using NSCache
 */
public final class SimpleCache: Cache {

    private let delegate = LRUCache<Date, Double>()
    
    public var size: Int {
        delegate.count
    }
    
    public func update(for key: Date, with value: Double) {
        return delegate.setValue(value, forKey: key)
    }
    
    public func getValue(for key: Date) -> Double? {
        return delegate.value(forKey: key)
    }
    
    public func removeValue(for key: Date) {
        delegate.removeValue(forKey: key)
    }
    
    public func clear() {
        delegate.removeAllValues()
    }
    
}
