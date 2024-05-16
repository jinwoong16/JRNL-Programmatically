//
//  DefaultJournalListViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

final class DefaultJournalListViewUseCase: JournalListViewUseCase {
    private let journalService: JournalService
    
    init(journalService: JournalService) {
        self.journalService = journalService
    }
    
    func fetchAll() -> AnyPublisher<[Journal], Never> {
        journalService
            .read()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func receiveAppendingEvent() -> AnyPublisher<Journal, Never> {
        journalService.appendEvent()
    }
}
