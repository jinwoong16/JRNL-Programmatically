//
//  JournalFileContainer.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation

// TODO: - Refactor this logic first
actor JournalFileContainer: Container {
    private let fileManager: FileManager = .default
    
    func read() throws -> [Journal] {
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = path.appendingPathComponent("journalData.json", conformingTo: .json)
        let data = try Data(contentsOf: fileUrl)
        
        return try JSONDecoder().decode([Journal].self, from: data)
    }
    
    func write(with element: Journal) throws {
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        try fileManager.createDirectory(at: path, withIntermediateDirectories: true)
        var elements: [Journal] = []
        if let existingData = try? read() {
            elements.append(contentsOf: existingData)
        }
        elements.append(element)
        
        let fileUrl = path.appendingPathComponent("journalData.json", conformingTo: .json)
        let jsonData = try JSONEncoder().encode(elements)
        try jsonData.write(to: fileUrl)
    }
}
