//
//  Court.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
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
