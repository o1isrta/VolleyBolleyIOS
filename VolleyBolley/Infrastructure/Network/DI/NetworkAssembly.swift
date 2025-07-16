//
//  NetworkAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Moya
import Swinject

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {

        container.register(MoyaProvider<UsersAPI>.self) { _ in
            let logger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
            return MoyaProvider<UsersAPI>(plugins: [logger])
        }
        .inObjectScope(.container)

        container.register(UsersService.self) { resolver in
            let provider = resolver.resolve(MoyaProvider<UsersAPI>.self)!
            return UsersService(provider: provider)
        }

        container.register(UsersRepository.self) { resolver in
            let service = resolver.resolve(UsersService.self)!
            return UsersRepository(service: service)
        }
    }
}
