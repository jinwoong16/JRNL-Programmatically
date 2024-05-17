//
//  DefaultJournalListViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

final class DefaultJournalListViewUseCase: JournalListViewUseCase {
    private let journalRepository: JournalRepository
    
    init(journalRepository: JournalRepository) {
        self.journalRepository = journalRepository
    }
    
    func fetchAll() -> AnyPublisher<[Journal], Never> {
        journalRepository
            .read()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func receiveAppendingEvent() -> AnyPublisher<Journal, Never> {
        journalRepository.appendEvent()
    }
}
