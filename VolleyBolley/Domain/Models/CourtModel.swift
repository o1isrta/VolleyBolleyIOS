//
//  CourtModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import CoreLocation
import Foundation

struct CourtModel: Equatable {
	let id: UUID
	let name: String
	let shortDescription: String
	let fullDescription: String
	let coordinate: CLLocationCoordinate2D
	let imageUrl: URL?
	let price: String
	let phone: String

	static func == (lhs: CourtModel, rhs: CourtModel) -> Bool {
		lhs.coordinate.latitude == rhs.coordinate.latitude
		&& lhs.coordinate.longitude == rhs.coordinate.longitude
		&& lhs.name == rhs.name
	}
}
