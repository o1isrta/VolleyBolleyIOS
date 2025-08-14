//
//  CourtModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import Foundation

struct CourtModel: Decodable, Equatable {
	let id: Int
	let price: String?
	let description: String?
	let contacts: [ContactModel]?
	let imageUrl: URL?
	let tagList: [String]
	let location: LocationModel

	static func == (lhs: CourtModel, rhs: CourtModel) -> Bool {
		lhs.location.latitude == rhs.location.latitude
		&& lhs.location.longitude == rhs.location.longitude
		&& lhs.location.courtName == rhs.location.courtName
	}

	private enum CodingKeys: String, CodingKey {
		case id = "court_id"
		case price = "price_description"
		case description
		case contacts = "contact_list"
		case imageUrl = "photo_url"
		case tagList = "tag_list"
		case location = "court_location"
	}

	// swiftlint:disable line_length
	static var mockData = CourtModel(
		id: 1,
		price: "$20/hour",
		description: "A beautiful court in the heart of Central Park. Recently renovated, with night lighting and locker rooms.",
		contacts: [
			ContactModel(
				type: "PHONE",
				value: "+1 212-555-1234"
			)
		],
		imageUrl: nil,
		tagList: [
			"4 courts",
			"Outdoor"
		],
		location: LocationModel(
			latitude: 40.785091,
			longitude: -73.968285,
			courtName: "Central Park Court",
			locationName: "USA, New York"
		)
	)
	// swiftlint:enable line_length
}

struct ContactModel: Decodable {
	let type: String
	let value: String

	private enum CodingKeys: String, CodingKey {
		case type = "contact_type"
		case value = "contact"
	}
}
