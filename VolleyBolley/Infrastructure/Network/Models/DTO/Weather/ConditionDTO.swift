//
//  ConditionDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import Foundation

struct ConditionDTO: Decodable {
    let code: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case code
        case description
    }
}
