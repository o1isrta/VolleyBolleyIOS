//
//  CourtsNetworkAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.09.2025.
//

import Moya
import Swinject

final class CourtsNetworkAssembly: BaseNetworkAssembly {
    func assemble(container: Container) {

        registerMoyaProvider(CourtsAPI.self, container: container)

        registerService(
            CourtsService.self,
            protocolType: CourtsServiceProtocol.self,
            providerType: CourtsAPI.self,
            container: container
        )

        registerRepository(
            CourtsRepository.self,
            protocolType: CourtsRepositoryProtocol.self,
            serviceType: CourtsServiceProtocol.self,
            container: container
        )
    }
}
