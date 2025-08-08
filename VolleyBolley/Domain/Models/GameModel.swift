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
		case levels
		case gender
		case pricePerPerson = "price_per_person"
		case currencyType = "currency_type"
		case paymentType = "payment_type"
		case paymentAccount = "payment_account"
		case maximumPlayers = "maximum_players"
		case players
	}

	static var mockData = GameModel(
		gameId: 0,
		gameType: "MY GAMES",
		host: HostModel(
			id: 0,
			firstName: "Artem",
			lastName: "Ivanov",
			avatarURL: "url",
			levelType: "PRO"
		),
		message: "Afterlunch meet. 2$ entry fee, our favorite place, don’t miss",
		courtLocation: LocationModel(
			latitude: 40.785091,
			longitude: -73.968285,
			courtName: "Central Park Court",
			locationName: "USA, New York"
		),
		startTime: "2025-07-01 14:30",
		endTime: "2025-07-01 15:30",
		levels: [
			"PRO",
			"LIGHT"
		],
		gender: "MEN",
		pricePerPerson: "5",
		currencyType: "EUR",
		paymentType: "REVOLUT",
		paymentAccount: "1234",
		maximumPlayers: 4,
		players: [PlayerModel(
			playerId: 0,
			firstName: "Test",
			lastName: "Test",
			level: "PRO"
		)]
	)
}
