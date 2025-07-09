//
//  DistanceService.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import Foundation

protocol DistanceServiceProtocol {
    func calculateDistance(from userLocation: CLLocation, to coordinate: CLLocationCoordinate2D) -> Double
    func calculateDistances(from userLocation: CLLocation, to courts: [CourtModel]) -> [(court: CourtModel, distance: Double)]
}

class DistanceService: DistanceServiceProtocol {
    func calculateDistance(from userLocation: CLLocation, to coordinate: CLLocationCoordinate2D) -> Double {
        let courtLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return userLocation.distance(from: courtLocation) / 1000 // Convert to kilometers
    }
    
    func calculateDistances(from userLocation: CLLocation, to courts: [CourtModel]) -> [(court: CourtModel, distance: Double)] {
        print("🔍 DistanceService: Calculating distances for \(courts.count) courts") // TODO
        print("📍 User location: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
        
        return courts.map { court in
            let distance = calculateDistance(from: userLocation, to: court.coordinate)
            print("🏀 Court '\(court.name)': \(distance) km") // TODO
            return (court: court, distance: distance)
        }
    }
}
