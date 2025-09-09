//
//  Court.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation

struct Court {
    let id: Int
    let name: String
    let description: String?
    let address: String
    let location: GeoPoint
    let priceDescription: String?
    let photoURL: URL?
    let tags: [String]?
    let contacts: [Contact]
}
