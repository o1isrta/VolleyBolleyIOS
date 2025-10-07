//
//  LocationError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Foundation

/// A domain-specific error that explains why obtaining the user’s location failed.
///
/// Cases:
/// - `permissionDenied`: The user explicitly denied location authorization for the app.
/// - `restricted`: Location access is restricted by system policies (e.g., Screen Time,
///   parental controls, MDM) and cannot be changed by the user.
///   - Recovery: Inform the user that access is restricted and cannot be modified from the app.
/// - `unavailable`: Location services are temporarily unavailable (e.g., disabled services,
///   hardware failure, network issues, or a request timed out).
///   - Recovery: Ask the user to ensure Location Services are enabled and try again later.
/// - `notFound`: The system could not determine a valid location (e.g., GPS couldn’t obtain
///   a fix due to poor signal or being indoors).
///   - Recovery: Suggest moving to an open area, checking connectivity, and retrying.
///
/// Mapping to Core Location (for reference):
/// - `permissionDenied`: `CLError.denied`, or authorization status `.denied`.
/// - `restricted`: Authorization status `.restricted` (system‑enforced).
/// - `unavailable`: `CLLocationManager.locationServicesEnabled() == false`,
///   `CLError.network`, or prolonged `CLError.locationUnknown`/timeout.
/// - `notFound`: `CLError.locationUnknown` when no fix is currently available.
enum LocationError: Error {
    case permissionDenied
    case restricted
    case unavailable
    case notFound
}
