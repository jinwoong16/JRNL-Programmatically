//
//  JournalListViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

protocol JournalListViewUseCase {
    func fetchAll() -> [Journal]
    func receiveAppendingEvent() -> AnyPublisher<Journal, Never>
}
