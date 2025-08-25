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
		let courts = CourtModel.mockDataArray
//		courts.append(CourtModel.mockDataForUITets)
		completion(courts)
	}
}
