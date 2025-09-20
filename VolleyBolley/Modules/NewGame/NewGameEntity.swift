//
//  NewGameEntity.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 19.09.2025.
//
import Foundation

enum Gender {
    case mix, men, women
}

enum PlayerLevel {
    case light, medium, hard, pro
}

struct GameEntity {
    let message: String
    let place: String
    let date: Date
    let from: Date
    let to: Date
    let gender: Gender
    let level: PlayerLevel
}
