//
//  AddJournalViewModel.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/16/24.
//

import Foundation
import Combine
import CoreLocation

final class AddJournalViewModel: NSObject {
    private let useCase: any AddJournalViewUseCase
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    @Published private(set) var isSuccess = false
    
    init(useCase: any AddJournalViewUseCase) {
        self.useCase = useCase
        super.init()
        
        configureLocationManager()
    }
    
    func clickSaveButton(
        _ title: String,
        body: String,
        photoData: Data?
    ) {
        useCase
            .save(
                journal: Journal(
                    rating: 5,
                    journalTitle: title,
                    journalDescription: body,
                    photoData: photoData,
                    latitude: currentLocation?.coordinate.latitude,
                    longitude: currentLocation?.coordinate.longitude
                )
            )
            .assign(to: &$isSuccess)
    }
}

extension AddJournalViewModel: CLLocationManagerDelegate {
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.requestLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            debugPrint(#function, "Could not specify current location.")
            return
        }
        self.currentLocation = currentLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
