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
            CourtModel(
                id: UUID(),
                name: "Central Park Court",
                shortDescription: "Open 24/7, lights available",
                fullDescription: "A beautiful court in the heart of Central Park. Recently renovated, with night lighting and locker rooms.",
                coordinate: CLLocationCoordinate2D(latitude: 40.785091, longitude: -73.968285),
                imageUrl: nil,
                price: "$20/hour",
                phone: "+1 212-555-1234"
            ),
            CourtModel(
                id: UUID(),
                name: "Riverside Court",
                shortDescription: "River view, free parking",
                fullDescription: "Court with a stunning view of the river. Free parking available for all visitors.",
                coordinate: CLLocationCoordinate2D(latitude: 40.800000, longitude: -73.970000),
                imageUrl: nil,
                price: "$15/hour",
                phone: "+1 212-555-5678"
            ),
            CourtModel(
                id: UUID(),
                name: "East Side Court",
                shortDescription: "Indoor, air conditioned",
                fullDescription: "Modern indoor court with air conditioning and equipment rental.",
                coordinate: CLLocationCoordinate2D(latitude: 40.780000, longitude: -73.955000),
                imageUrl: nil,
                price: "$25/hour",
                phone: "+1 212-555-9012"
            ),
            // for CourtTableViewCell ui tests
//            CourtModel(
//                id: UUID(),
//                name: "East Side Court, it's very long title just for tests",
//                shortDescription: "Indoor, air conditioned",
//                fullDescription: "Modern indoor court with air conditioning and equipment rental.",
//                coordinate: CLLocationCoordinate2D(latitude: 40.650000, longitude: -73.955000),
//                imageUrl: nil,
//                price: "$25/hour",
//                phone: "+1 212-555-9012"
//            )
        ]
        completion(courts)
    }
}
