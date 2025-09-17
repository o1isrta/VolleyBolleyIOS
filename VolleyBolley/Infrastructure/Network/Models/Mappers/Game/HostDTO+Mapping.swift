//
//  HostDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

extension HostDTO {
    func toDomain() -> Host {
        Host(
            id: playerId,
            firstName: firstName,
            lastName: lastName,
            avatarURL: avatar.flatMap { URL(string: $0) },
            level: PlayerLevel(fromServer: level)
        )
    }
}
