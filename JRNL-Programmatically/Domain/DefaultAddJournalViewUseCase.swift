//
//  DefaultAddJournalViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

final class DefaultAddJournalViewUseCase: AddJournalViewUseCase {
    private let journalRepository: JournalRepository
    
    init(journalRepository: JournalRepository) {
        self.journalRepository = journalRepository
    }
    
    func save(journal: Journal) -> AnyPublisher<Bool, Never> {
        journalRepository
            .write(with: journal)
            .map { true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
}
