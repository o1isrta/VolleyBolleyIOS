//
//  GameListItem.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 15.09.2025.
//

import Foundation

struct GameListItem {
    let id: Int
    let host: Host
    let location: CourtLocation
    let message: String
    let startTime: Date
    let endTime: Date
}
