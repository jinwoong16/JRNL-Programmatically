//
//  DefaultMapViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/17/24.
//

import Foundation
import Combine

final class DefaultMapViewUseCase: MapViewUseCase {
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
}
