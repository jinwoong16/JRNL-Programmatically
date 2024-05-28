//
//  Keys.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation

// MARK: - Journal File Container
struct JournalFileContainerKey: InjectionKey {
    typealias Value = JournalFileContainer
}

// MARK: - SwiftData Container
struct SwiftDataContainerKey: InjectionKey {
    typealias Value = SwiftDataContainer
}

// MARK: - Service
struct JournalRepositoryKey: InjectionKey {
    typealias Value = JournalRepository
}

// MARK: - UseCases
struct JournalListViewUseCaseKey: InjectionKey {
    typealias Value = JournalListViewUseCase
}

struct AddJournalViewUseCaseKey: InjectionKey {
    typealias Value = AddJournalViewUseCase
}

struct MapViewUseCaseKey: InjectionKey {
    typealias Value = MapViewUseCase
}
