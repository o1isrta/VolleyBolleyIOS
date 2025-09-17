//
//  GamesNetworkAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 15.09.2025.
//

import Moya
import Swinject

final class GamesNetworkAssembly: BaseNetworkAssembly {
    func assemble(container: Container) {

        registerMoyaProvider(GamesAPI.self, container: container)

        registerService(
            GamesService.self,
            protocolType: GamesServiceProtocol.self,
            providerType: GamesAPI.self,
            container: container
        )

        registerRepository(
            GamesRepository.self,
            protocolType: GamesRepositoryProtocol.self,
            serviceType: GamesServiceProtocol.self,
            container: container
        )
    }
}
