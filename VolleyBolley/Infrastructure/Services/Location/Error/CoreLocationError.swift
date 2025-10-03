//
//  CoreLocationError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 26.09.2025.
//

import Foundation

enum CoreLocationError: Error {
    case notDetermined
    case denied
    case restricted
    case failed
    case notFound
    case timeout
}
