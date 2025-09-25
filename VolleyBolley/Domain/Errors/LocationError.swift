//
//  LocationError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Foundation

enum LocationError: Error {
    case notDetermined
    case denied
    case restricted
    case failed
    case notFound
    case timeout
}
