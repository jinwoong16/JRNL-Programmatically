//
//  Journal.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import UIKit
import MapKit
import SwiftData

@Model
final class Journal: Identifiable, Codable {
    let id: UUID
    let date: Date
    let rating: Int
    let journalTitle: String
    let journalDescription: String
    let photoData: Data?
    let latitude: Double?
    let longitude: Double?
    
    init(
        id: UUID = UUID(),
        date: Date = .now,
        rating: Int,
        journalTitle: String,
        journalDescription: String,
        photoData: Data?,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.id = id
        self.date = date
        self.rating = rating
        self.journalTitle = journalTitle
        self.journalDescription = journalDescription
        self.photoData = photoData
        self.latitude = latitude
        self.longitude = longitude
    }
    
    enum CodingKeys: CodingKey {
        case id, date, rating, journalTitle, journalDescription, photoData, latitude, longitude
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        rating = try container.decode(Int.self, forKey: .rating)
        journalTitle = try container.decode(String.self, forKey: .journalTitle)
        journalDescription = try container.decode(String.self, forKey: .journalDescription)
        photoData = try? container.decode(Data.self, forKey: .photoData)
        latitude = try? container.decode(Double.self, forKey: .latitude)
        longitude = try? container.decode(Double.self, forKey: .longitude)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(rating, forKey: .rating)
        try container.encode(journalTitle, forKey: .journalTitle)
        try container.encode(journalDescription, forKey: .journalDescription)
        try container.encode(photoData, forKey: .photoData)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}
