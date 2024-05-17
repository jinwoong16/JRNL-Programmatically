//
//  DefaultAddJournalViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

final class DefaultAddJournalViewUseCase: AddJournalViewUseCase {
    private let journalService: JournalRepository
    
    init(journalService: JournalRepository) {
        self.journalService = journalService
    }
    
    func save(journal: Journal) -> AnyPublisher<Bool, Never> {
        journalService
            .write(with: journal)
            .map { true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
}
