//
//  CourtModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import Foundation

protocol MapInteractorProtocol: AnyObject {
	func fetchCourts(completion: @escaping ([CourtModel]) -> Void)
}

final class MapInteractor: MapInteractorProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func fetchCourts(completion: @escaping ([CourtModel]) -> Void) {
        // TODO: for tests
//        let query = "Karon"
//        networkService.searchCourts(query: query) { result in
//            switch result {
//            case .success(let response):
//                let courts = response.courts.map{ $0.toDomain() }
//                completion([])
//            case .failure(let error):
//                completion([])
//            }
//        }
        // TODO: for tests
        networkService.getCountryList { result in
            switch result {
            case .success(let response):
                completion([])
            case .failure(let error):
                completion([])
            }
        }

        let courts = CourtModel.mockDataArray
        completion(courts)
    }
}
