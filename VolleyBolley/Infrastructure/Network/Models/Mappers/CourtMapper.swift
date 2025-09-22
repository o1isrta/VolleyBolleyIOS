//
//  CourtMapper.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.09.2025.
//

import Foundation

extension CourtDTO {
    func toDomain() -> Court {
        Court(
            id: courtId,
            name: courtLocation.courtName,
            details: description,
            address: courtLocation.locationName,
            coordinates: Coordinates(
                latitude: courtLocation.latitude,
                longitude: courtLocation.longitude
            ),
            pricingInfo: priceDescription,
            photoURL: photoURL,
            tags: tags,
            contacts: contactList.map { Court.Contact(phone: $0.contact) }
        )
    }
}
