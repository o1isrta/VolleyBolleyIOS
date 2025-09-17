//
//  TournamentListItemDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

extension TournamentListItemDTO {
    func toDomain() -> TournamentListItem {
        TournamentListItem(
            id: tournamentId,
            host: host.toDomain(),
            location: courtLocation.toDomain(),
            message: message,
            startTime: startTime,
            endTime: endTime
        )
    }
}
