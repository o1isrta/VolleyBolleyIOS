//
//  NearbyCourtUseCaseProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

protocol NearbyCourtUseCaseProtocol {
    /// Получить ближайшую площадку и прогноз погоды
    func getNearbyCourt(completion: @escaping (Result<CourtWithWeather, Error>) -> Void)
}
