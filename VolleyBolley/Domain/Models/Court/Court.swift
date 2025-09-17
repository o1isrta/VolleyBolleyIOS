//
//  Court.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation

struct Court {
    let id: Int
    let description: String?
    let location: CourtLocation
    let priceDescription: String?
    let photoURL: URL?
    let tags: [String]?
    let contacts: [Contact]
}
