//
//  Injected.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation

@propertyWrapper
final class Injected<Value> {
    private var storage: Value
    
    var wrappedValue: Value {
        storage
    }
    
    init<K>(_ key: K.Type) where K: InjectionKey, Value == K.Value {
        storage = key.currentValue
    }
}
