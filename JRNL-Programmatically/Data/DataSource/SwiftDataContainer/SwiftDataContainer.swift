//
//  SwiftDataContainer.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/17/24.
//

import Foundation
import SwiftData

@ModelActor
actor SwiftDataContainer {
    private func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T: PersistentModel {
        return try self.modelContext.fetch(descriptor)
    }
    
    private func insert<T>(data: T) where T: PersistentModel {
        let context = data.modelContext ?? modelContext
        context.insert(data)
    }
}

extension SwiftDataContainer: Container {
    func read() async throws -> [Journal] {
        try fetch(FetchDescriptor<Journal>())
    }
    
    func write(with element: Journal) async throws {
        insert(data: element)
    }
}
