//
//  AddJournalViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

protocol AddJournalViewUseCase {
    func save(journal: Journal) -> AnyPublisher<Bool, Never>
}
