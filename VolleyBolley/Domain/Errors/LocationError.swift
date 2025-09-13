//
//  LocationError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.09.2025.
//

import Foundation

enum LocationError: Error {
    case notDetermined
    case denied
    case restricted
    case failed
    case notFound
}

extension LocationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notDetermined:
            return NSLocalizedString("Location permission not determined.", comment: "")
        case .denied:
            return NSLocalizedString("Location access was denied. Please enable it in Settings.", comment: "")
        case .restricted:
            return NSLocalizedString("Location access is restricted.", comment: "")
        case .failed:
            return NSLocalizedString("Failed to get your location.", comment: "")
        case .notFound:
            return NSLocalizedString("Could not determine your location.", comment: "")
        }
    }
}
