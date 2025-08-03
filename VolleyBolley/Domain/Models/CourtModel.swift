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
}

struct ContactModel: Decodable {
	let type: String
	let value: String

	private enum CodingKeys: String, CodingKey {
		case type = "contact_type"
		case value = "contact"
	}
}
