//
//  CourtModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import Foundation

protocol MapInteractorProtocol: AnyObject {
	func fetchCourts(completion: @escaping ([CourtModel]) -> Void)
}

final class MapInteractor: MapInteractorProtocol {

	// MARK: - Public Methods

	func fetchCourts(completion: @escaping ([CourtModel]) -> Void) {
		let courts = [
			// swiftlint:disable line_length
			CourtModel(
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
				location: CourtLocationModel(
					latitude: 40.785091,
					longitude: -73.968285,
					courtName: "Central Park Court",
					locationName: "USA, New York"
				)
			),
			CourtModel(
				id: 2,
				price: "$15/hour",
				description: "Court with a stunning view of the river. Free parking available for all visitors.",
				contacts: [
					ContactModel(
						type: "PHONE",
						value: "+1 212-555-5678"
					)
				],
				imageUrl: nil,
				tagList: [
					"4 courts",
					"Outdoor",
					"Seasonal",
					"Lights"
				],
				location: CourtLocationModel(
					latitude: 40.800000,
					longitude: -73.970000,
					courtName: "Riverside Court",
					locationName: "USA, New York"
				)
			),
			CourtModel(
				id: 3,
				price: "$25/hour",
				description: "Modern indoor court with air conditioning and equipment rental.",
				contacts: [
					ContactModel(
						type: "PHONE",
						value: "+1 212-555-9012"
					)
				],
				imageUrl: nil,
				tagList: [
					"4 courts",
					"Outdoor",
					"Seasonal"
				],
				location: CourtLocationModel(
					latitude: 40.780000,
					longitude: -73.955000,
					courtName: "East Side Court",
					locationName: "USA, New Arc"
				)
			),
			// for CourtTableViewCell ui tests
//			CourtModel(
//				id: 4,
//				price: "$25/hour",
//				description: "Modern indoor court with air conditioning and equipment rental.",
//				contacts: [
//					ContactModel(
//						type: "PHONE",
//						value: "+1 212-555-9012"
//					)
//				],
//				imageUrl: nil,
//				tagList: [
//					"4 courts",
//					"Outdoor",
//					"Seasonal",
//					"Lights"
//				],
//				location: CourtLocationModel(
//					latitude: 40.650000,
//					longitude: -73.955000,
//					courtName: "East Side Court, it's very long title just for tests",
//					locationName: "USA, New Arc"
//				)
//			)
			// swiftlint:enable line_length
		]
		completion(courts)
	}
}
