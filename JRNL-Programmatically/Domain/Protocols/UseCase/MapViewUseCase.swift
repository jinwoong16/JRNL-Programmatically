//
//  MapViewUseCase.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/17/24.
//

import Foundation
import Combine

protocol MapViewUseCase {
    func fetchAll() -> AnyPublisher<[Journal], Never>
}
