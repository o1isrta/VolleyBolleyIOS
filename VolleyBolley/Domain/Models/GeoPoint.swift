//
//  GeoPoint.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation

/// A simple geographic coordinate consisting of latitude and longitude in decimal degrees.
///
/// Use `GeoPoint` to represent positions on the Earth and to compute distances
/// between two points using the Haversine formula.
///
/// - Note:
///   - Latitude (`lat`) is expressed in decimal degrees north of the equator (south is negative).
///   - Longitude (`lon`) is expressed in decimal degrees east of the Prime Meridian (west is negative).
///
/// - Example:
///   Create two points and compute the distance between them:
///   ```swift
///   let a = GeoPoint(lat: 40.7128, lon: -74.0060) // New York
///   let b = GeoPoint(lat: 34.0522, lon: -118.2437) // Los Angeles
///   let km = a.distanceInKilometers(to: b)
///   ```
///
/// - SeeAlso: `distanceInKilometers(to:)`
///
/// A latitude in decimal degrees.
struct GeoPoint {
    let lat: Double
    let lon: Double

    /// Computes the great-circle distance to another geographic point in kilometers using the Haversine formula.
    /// 
    /// This method treats the Earth as a sphere with a mean radius of 6,371 km and calculates the shortest
    /// path over the Earth's surface between the receiver and the specified point. The result is rounded to
    /// one decimal place.
    /// 
    /// - Parameter other: The destination `GeoPoint` to which the distance will be calculated.
    /// - Returns: The distance between the two points in kilometers, rounded to one decimal place.
    /// 
    /// - Important: Input coordinates are expected to be in decimal degrees (latitude and longitude).
    /// - Note: This approximation assumes a spherical Earth and may introduce small errors compared to
    ///   ellipsoidal models, especially over very long distances.
    /// 
    /// - SeeAlso: `GeoPoint`
    /// 
    /// - Example:
    ///   ```swift
    ///   let nyc = GeoPoint(lat: 40.7128, lon: -74.0060)
    ///   let la  = GeoPoint(lat: 34.0522, lon: -118.2437)
    ///   let distance = nyc.distanceInKilometers(to: la) // e.g., 3935.8
    ///   ```
    func distanceInKilometers(to other: GeoPoint) -> Double {
        let earthRadiusKm = 6371.0
        let deltaLatitude = (other.lat - lat) * .pi / 180
        let deltaLongitude = (other.lon - lon) * .pi / 180

        let haversineLat = sin(deltaLatitude / 2) * sin(deltaLatitude / 2)
        let haversineLon = cos(lat * .pi / 180) * cos(other.lat * .pi / 180) *
                           sin(deltaLongitude / 2) * sin(deltaLongitude / 2)

        let haversine = haversineLat + haversineLon
        let angularDistance = 2 * atan2(sqrt(haversine), sqrt(1 - haversine))
        let distanceKm = earthRadiusKm * angularDistance

        return (distanceKm * 10).rounded() / 10
    }
}
