//
//  Module.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation

struct Module {
    let name: String
    let resolve: () -> Any
    
    init<T: InjectionKey>(_ name: T.Type, _ resolve: @escaping () -> Any) {
        self.name = String(describing: name)
        self.resolve = resolve
    }
}

