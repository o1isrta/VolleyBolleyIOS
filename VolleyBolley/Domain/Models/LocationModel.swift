//
//  LocationModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import Foundation

struct LocationModel: Codable {
	let latitude: Double
	let longitude: Double
	let courtName: String
	let locationName: String

	private enum CodingKeys: String, CodingKey {
		case latitude
		case longitude
		case courtName = "court_name"
		case locationName = "location_name"
	}
}
