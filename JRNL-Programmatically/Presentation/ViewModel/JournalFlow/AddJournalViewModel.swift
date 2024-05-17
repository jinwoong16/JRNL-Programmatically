//
//  AddJournalViewModel.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

final class AddJournalViewModel {
    private let useCase: AddJournalViewUseCase
    @Published private(set) var isSuccess = false
    
    init(useCase: AddJournalViewUseCase) {
        self.useCase = useCase
    }

    func save(with journal: Journal) {
        useCase
            .save(journal: journal)
            .assign(to: &$isSuccess)
    }
}
