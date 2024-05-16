//
//  JournalService.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine

final class JournalService {
    private let container: any Container<Journal>
    private var appendingEvent = PassthroughSubject<Journal, Never>()
    
    init(container: any Container<Journal>) {
        self.container = container
    }
    
    func read() -> AnyPublisher<[Journal], Error> {
        Future<[Journal]?, Error> { promise in
            Task { [weak self] in
                do {
                    promise(.success(try await self?.container.read()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }
    
    func write(with journal: Journal) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            Task { [weak self] in
                do {
                    try await self?.container.write(with: journal)
                    self?.appendingEvent.send(journal)
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func appendEvent() -> AnyPublisher<Journal, Never> {
        appendingEvent.eraseToAnyPublisher()
    }
}
