//
//  LocationServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import CoreLocation

protocol LocationServiceProtocol {
    func requestLocation(completion: @escaping (CLLocation?) -> Void)
}
