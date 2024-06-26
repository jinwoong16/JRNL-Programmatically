//
//  JournalMock.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import Foundation

extension Journal {
    static var mock: Journal {
        Self.mocks[0]
    }
    
    static var mocks: [Journal] {
        [
            .init(
                rating: 0,
                journalTitle: "Bad",
                journalDescription: "Today is bad day",
                photoData: nil
            ),
            .init(
                rating: 5,
                journalTitle: "Good",
                journalDescription: "Today is good day",
                photoData: nil
            ),
            .init(
                rating: 3,
                journalTitle: "Ok",
                journalDescription: "Today is Ok day",
                photoData: nil
            )
        ]
    }
}
