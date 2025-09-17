//
//  TournamentListItem.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

struct TournamentListItem {
    let id: Int
    let host: Host
    let location: CourtLocation
    let message: String
    let startTime: Date
    let endTime: Date
}
