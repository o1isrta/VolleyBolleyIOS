//
//  NearbyCourtUseCase.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation

// final class NearbyCourtUseCase: NearbyCourtUseCaseProtocol {
//    private let locationRepository: LocationRepositoryProtocol
//    private let courtRepository: CourtsRepositoryProtocol
//    // private let weatherRepository: WeatherRepositoryProtocol
//
//    init(locationRepository: LocationRepositoryProtocol,
//         courtRepository: CourtsRepositoryProtocol
//         /*weatherRepository: WeatherRepositoryProtocol*/) {
//        self.locationRepository = locationRepository
//        self.courtRepository = courtRepository
//        // self.weatherRepository = weatherRepository
//    }
//
//    func getNearbyCourt(completion: @escaping (Result<CourtWithWeather, Error>) -> Void) {
//        locationRepository.getUserLocation { [weak self] geoPoint in
//            guard let self, let userLocation = geoPoint else {
//                completion(.failure(NSError(domain: "LocationError", code: 0)))
//                return
//            }
//
//            // Получаем все площадки
//            self.courtRepository.getCourts { result in
//                switch result {
//                case .success(let courts):
//                    // Выбираем ближайшую
////                    guard let nearest = courts.min(by: {
////                        $0.location.distance(to: userLocation) < $1.location.distance(to: userLocation)
////                    }) else {
////                        completion(.failure(NSError(domain: "NoCourts", code: 0)))
////                        return
////                    }
//
//                    // Подгружаем погоду
////                    self.weatherRepository.getWeather(for: nearest.location) { weatherResult in
////                        switch weatherResult {
////                        case .success(let weather):
////                            let courtWithWeather = CourtWithWeather(court: nearest, weather: weather)
////                            completion(.success(courtWithWeather))
////                        case .failure(let error):
////                            completion(.failure(error))
////                        }
////                    }
//
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
// }
