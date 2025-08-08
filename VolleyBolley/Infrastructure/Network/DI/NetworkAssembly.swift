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

        container.register(MoyaProvider<UsersAPI>.self) { resolver in
            guard let environment = resolver.resolve(AppEnvironment.self) else {
                fatalError("AppEnvironment is not resolved")
            }

            let logger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))

            let endpointClosure: (UsersAPI) -> Endpoint = { target in
                let url = environment.baseURL.appendingPathComponent(target.path).absoluteString

                return Endpoint(
                    url: url,
                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }

//            let endpointClosure: (UsersAPI) -> Endpoint = { target in
//                let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
//                return defaultEndpoint.replacing(baseURL: environment.baseURL)
//            }

            let stubClosure: (UsersAPI) -> StubBehavior = environment.useStubbedProvider //NetworkEnvironment.current.useStubbedProvider
                ? { _ in .immediate }
                : MoyaProvider.neverStub

            return MoyaProvider<UsersAPI>(
                endpointClosure: endpointClosure,
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
