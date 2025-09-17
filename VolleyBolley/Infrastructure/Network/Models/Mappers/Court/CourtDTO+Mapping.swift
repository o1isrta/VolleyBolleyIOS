//
//  CourtDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation

extension CourtDTO {
    func toDomain() -> Court {
        let parsedURL: URL?

        if let photoUrl {
            parsedURL = URL(string: photoUrl)
        } else {
            parsedURL = nil
        }

        return Court(
            id: courtId,
            description: description,
            location: location.toDomain(),
            priceDescription: priceDescription,
            photoURL: parsedURL,
            tags: tagList,
            contacts: contactList?.map { $0.toDomain() } ?? []
        )
    }
}

extension CourtDTO.ContactDTO {
    func toDomain() -> Contact {
        Contact(type: contactType, value: contact)
    }
}
