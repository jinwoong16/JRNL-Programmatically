//
//  Module.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation

final class Module {
    let name: String
    let resolve: () -> Any
    var resolved: Any? = nil
    
    init<T: InjectionKey>(_ name: T.Type, _ resolve: @escaping () -> Any) {
        self.name = String(describing: name)
        self.resolve = resolve
    }
    
    deinit {
        print("Module de init")
    }
}

