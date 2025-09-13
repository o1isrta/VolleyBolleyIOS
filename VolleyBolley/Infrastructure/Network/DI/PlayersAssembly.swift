//
//  PlayersAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.09.2025.
//

import Moya
import Swinject

final class PlayersAssembly: BaseNetworkAssembly {

    func assemble(container: Container) {
        registerMoyaProvider(PlayersAPI.self, container: container)

        registerService(
            PlayersService.self,
            protocolType: PlayersServiceProtocol.self,
            providerType: PlayersAPI.self,
            container: container
        )
        registerRepository(
            PlayersRepository.self,
            protocolType: PlayersRepositoryProtocol.self,
            serviceType: PlayersServiceProtocol.self,
            container: container
        )
    }
}
