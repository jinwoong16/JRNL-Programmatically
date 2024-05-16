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

// MARK: - Service
struct JournalServiceKey: InjectionKey {
    typealias Value = JournalService
}

// MARK: - UseCases
struct JournalListViewUseCaseKey: InjectionKey {
    typealias Value = JournalListViewUseCase
}

struct AddJournalViewUseCaseKey: InjectionKey {
    typealias Value = AddJournalViewUseCase
}
