//
//  LocationRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

protocol LocationRepositoryProtocol {
    func getUserLocation(completion: @escaping (GeoPoint?) -> Void)
}
