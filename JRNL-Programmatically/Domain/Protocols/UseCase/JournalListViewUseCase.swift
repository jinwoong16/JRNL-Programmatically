//
//  JournalListViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

protocol JournalListViewUseCase {
    func fetchAll() -> AnyPublisher<[Journal], Never>
    func receiveAppendingEvent() -> AnyPublisher<Journal, Never>
}
