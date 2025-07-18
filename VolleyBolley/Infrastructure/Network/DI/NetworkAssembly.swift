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

            let stubClosure: (UsersAPI) -> StubBehavior = NetworkEnvironment.current.useStubbedProvider
                ? { _ in .immediate }
                : MoyaProvider.neverStub

            return MoyaProvider<UsersAPI>(
                stubClosure: stubClosure,
                plugins: [logger]
            )
        }
        .inObjectScope(.container)

        container.register(UsersServiceProtocol.self) { resolver in
            guard
                let provider = resolver.resolve(MoyaProvider<UsersAPI>.self)
            else {
                fatalError("Error: Failed to resolve MoyaProvider<UsersAPI>")
            }

            return UsersService(provider: provider)
        }
        .inObjectScope(.container)

        container.register(UsersRepositoryProtocol.self) { resolver in
            guard let userService = resolver.resolve(UsersServiceProtocol.self) else {
                fatalError("Error: Failed to resolve UsersService>")
            }

            return UsersRepository(service: userService)
        }
        .inObjectScope(.container)
    }
}
