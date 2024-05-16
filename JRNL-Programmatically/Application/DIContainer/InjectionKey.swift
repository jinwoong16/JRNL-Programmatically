//
//  InjectionKey.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation

protocol InjectionKey {
    associatedtype Value
    static var currentValue: Self.Value { get }
}

extension InjectionKey {
    static var currentValue: Value {
        DIContainer.shared.resolve(for: Self.self)
    }
}

