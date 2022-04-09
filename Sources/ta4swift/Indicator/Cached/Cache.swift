//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 27.03.22.
//

import Foundation


public protocol Cache {
    
    var size: Int { get }
    func clear()
    func update(for currentTime: Date, with value: Double)
    func getValue(for key: Date) -> Double?
    
}

extension Cache {
    
    subscript(key: Date) -> Double? {
        get {
            return getValue(for: key)
        }
        
        set {
            if let nv = newValue {
                update(for: key, with: nv)
            }
        }
    }
}

extension ValueIndicator {
    
    /**
     Returns a cached version of this indicator using the provided cache
     */
    func cached(cache: @escaping () -> Cache = { return SimpleCache() }) -> CachedIndicator {
        return CachedIndicator(of: self, cache: cache)
    }
    
    
}
