//
//  JournalFileContainer.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation

actor JournalFileContainer: Container {
    private let fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    func read() async throws -> [Journal] {
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = path.appendingPathComponent("journalData.json", conformingTo: .json)
        let data = try Data(contentsOf: fileUrl)
        return try JSONDecoder().decode([Journal].self, from: data)
    }
    
    func write(with element: Journal) async throws {
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        try fileManager.createDirectory(at: path, withIntermediateDirectories: true)
        let fileUrl = path.appendingPathComponent("journalData.json", conformingTo: .json)
        let jsonData = try JSONEncoder().encode(element)
        try jsonData.write(to: fileUrl)
    }
}
