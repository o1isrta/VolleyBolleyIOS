//
//  CourtDTO.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

struct CourtDTO: Codable {
	let id: Int
	let price: String?
	let description: String?
	let contacts: [ContactModel]?
	let photoURL: String?
	let tagList: [String]?
	let location: LocationModel

	private enum CodingKeys: String, CodingKey {
		case id = "court_id"
		case price = "price_description"
		case description
		case contacts = "contact_list"
		case photoURL = "photo_url"
		case tagList = "tag_list"
		case location = "court_location"
	}

	func toDomain() -> CourtModel {
		let parsedImageURL = URL(string: photoURL ?? "")

		return CourtModel(
			id: id,
			price: price,
			description: description,
			contacts: contacts,
			imageUrl: parsedImageURL,
			tagList: tagList ?? [],
			location: location
		)
	}
}
