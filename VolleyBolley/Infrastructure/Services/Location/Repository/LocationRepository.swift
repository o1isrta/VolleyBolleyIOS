//
//  LocationRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

final class LocationRepository: LocationRepositoryProtocol {
    private let service: LocationServiceProtocol

    init(service: LocationServiceProtocol) {
        self.service = service
    }

    func getUserLocation(completion: @escaping (GeoPoint?) -> Void) {
        service.requestLocation { location in
            guard let loc = location else {
                completion(nil)
                return
            }
            completion(GeoPoint(lat: loc.coordinate.latitude,
                                lon: loc.coordinate.longitude))
        }
    }
}
