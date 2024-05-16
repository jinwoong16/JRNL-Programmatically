//
//  Container.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation

protocol Container<Element> {
    associatedtype Element: Codable
    func read() async throws -> [Element]
    func write(with element: Element) async throws
}
