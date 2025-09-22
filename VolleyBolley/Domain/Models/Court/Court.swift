//
//  Court.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import Foundation

struct Court {
    let id: Int
    let name: String
    let details: String?
    let address: String
    let coordinates: Coordinates
    let pricingInfo: String?
    let photoURL: URL?
    let tags: [String]?
    let contacts: [Contact]

    struct Contact {
        let phone: String
    }
}
