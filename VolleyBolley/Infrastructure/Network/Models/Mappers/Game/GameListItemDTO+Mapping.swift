//
//  GameListItemDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

extension GameListItemDTO {
    func toDomain() -> GameListItem {
        GameListItem(
            id: gameId,
            host: host.toDomain(),
            location: courtLocation.toDomain(),
            message: message,
            startTime: startTime,
            endTime: endTime
        )
    }
}
