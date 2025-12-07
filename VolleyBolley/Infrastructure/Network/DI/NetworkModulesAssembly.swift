//
//  NetworkModulesAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Moya
import Swinject

final class NetworkModulesAssembly: Assembly {

    func assemble(container: Container) {

        container.register(MoyaProvider<DataAPI>.self) { resolver in
            let environment = resolver.safeResolve(AppEnvironment.self)

            return MoyaProvider<DataAPI>(
                endpointClosure: self.makeEndpointClosure(environment: environment),
                stubClosure: self.makeStubClosure(environment: environment),
                plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
            )
        }
        .inObjectScope(.container)

        container.register(NetworkServiceProtocol.self) { resolver in
            let provider = resolver.safeResolve(MoyaProvider<DataAPI>.self)
            let tokenStorage = resolver.safeResolve(TokenStorageProtocol.self)

            return NetworkService(provider: provider) { tokenStorage.accessToken }
        }
        .inObjectScope(.container)

        container.register(AuthRepositoryProtocol.self) { resolver in
            let networkService = resolver.resolve(NetworkServiceProtocol.self)!

            return AuthRepository(service: networkService)
        }
    }

    // MARK: - Private methods

    private func makeEndpointClosure<T: TargetType>(
        environment: AppEnvironment
    ) -> (T) -> Endpoint {
        { target in
            let url = environment.baseURL.appendingPathComponent(target.path).absoluteString
            return Endpoint(
                url: url,
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
    }

    private func makeStubClosure<T: TargetType>(
        environment: AppEnvironment
    ) -> (T) -> StubBehavior {
        environment.useStubbedProvider ? { _ in .immediate } : MoyaProvider.neverStub
    }
}
