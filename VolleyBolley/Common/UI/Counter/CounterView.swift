//
//  CounterView.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 21.08.2025.
//

import UIKit

/// Тип счетчика: для игроков или для команд
enum CounterType {
    case players
    case teams
    
    var minValue: Int {
        switch self {
        case .players: return Constants.minPlayers
        case .teams: return Constants.minTeams
        }
    }
    
    var maxValue: Int {
        Constants.maxValue
    }
    
    // MARK: - Constants
    private enum Constants {
        static let minPlayers = 4
        static let minTeams = 3
        static let maxValue = 24
    }
}


