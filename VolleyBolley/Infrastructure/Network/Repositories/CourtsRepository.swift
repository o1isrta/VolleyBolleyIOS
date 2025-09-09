//
//  CourtsRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 24.08.2025.
//

protocol CourtsRepositoryProtocol {
    func getCourts(completion: @escaping (Result<Court, Error>) -> Void)
}

final class CourtsRepository: CourtsRepositoryProtocol {
    private let service: CourtsServiceProtocol

    // MARK: - Initializers

    init(service: CourtsServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func getCourts(completion: @escaping (Result<Court, Error>) -> Void) {
        service.fetchCourts { result in
            switch result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
