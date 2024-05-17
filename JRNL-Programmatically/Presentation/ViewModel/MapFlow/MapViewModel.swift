//
//  MapViewModel.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/17/24.
//

import Foundation
import Combine

final class MapViewModel {
    private let useCase: any MapViewUseCase
    @Published private(set) var journals: [Journal] = []
    
    init(useCase: any MapViewUseCase) {
        self.useCase = useCase
    }
    
    func viewIsAppearing() {
        useCase
            .fetchAll()
            .assign(to: &$journals)
    }
}
