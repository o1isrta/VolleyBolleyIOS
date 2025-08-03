//
//  GameModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import Foundation

struct GameModel: Codable {
	let gameId: Int
	let gameType: String
	let host: HostModel
	let message: String
	let courtLocation: LocationModel
	let startTime, endTime: String
	let levels: [String]
	let gender: String
	let pricePerPerson: String
	let currencyType: String
	let paymentType: String
	let paymentAccount: String
	let maximumPlayers: Int
	let players: [PlayerModel]

	private enum CodingKeys: String, CodingKey {
		case gameId = "game_id"
		case gameType = "game_type"
		case host, message
		case courtLocation = "court_location"
		case startTime = "start_time"
		case endTime = "end_time"
		case levels, gender
		case pricePerPerson = "price_per_person"
		case currencyType = "currency_type"
		case paymentType = "payment_type"
		case paymentAccount = "payment_account"
		case maximumPlayers = "maximum_players"
		case players
	}
}
