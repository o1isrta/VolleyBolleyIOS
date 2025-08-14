//
//  HostModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import Foundation

struct HostModel: Codable {
	let id: Int
	let firstName: String
	let lastName: String
	let avatarURL: String
	let levelType: String

	private enum CodingKeys: String, CodingKey {
		case id
		case firstName = "first_name"
		case lastName = "last_name"
		case avatarURL = "avatar_url"
		case levelType = "level_type"
	}
}
