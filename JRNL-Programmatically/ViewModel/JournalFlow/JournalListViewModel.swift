//
//  JournalListViewModel.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import Foundation
import Combine

final class JournalListViewModel {
    private let useCase: any JournalListViewUseCase
    private var disposableBag = Set<AnyCancellable>()
    @Published private(set) var journals: [Journal] = []
    
    init(useCase: any JournalListViewUseCase) {
        self.useCase = useCase
    }
    
    func appendJournal(_ journal: Journal) {
        journals.append(journal)
    }
    
    func viewDidLoad() {
        useCase
            .fetchAll()
            .assign(to: &$journals)
        useCase
            .receiveAppendingEvent()
            .sink { [weak self] journal in
                self?.journals.append(journal)
            }
            .store(in: &disposableBag)
    }
}
