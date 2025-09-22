//
//  NetworkModulesAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Moya
import Swinject

final class NetworkModulesAssembly: Assembly {

	func assemble(container: Container) {

        container.register(MoyaProvider<DataAPI>.self) { resolver in
            guard
                let environment = resolver.resolve(AppEnvironment.self)
            else {
                fatalError("Error: Failed to resolve AppEnvironment")
            }

            return MoyaProvider<DataAPI>(
                endpointClosure: self.makeEndpointClosure(environment: environment),
                stubClosure: self.makeStubClosure(environment: environment),
                plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
            )
        }
        .inObjectScope(.container)

		container.register(NetworkServiceProtocol.self) { resolver in
			guard
                let provider = resolver.resolve(MoyaProvider<DataAPI>.self),
                let tokenStorage = resolver.resolve(TokenStorageProtocol.self)
            else {
				fatalError("Error: Failed to resolve TokenStorageProtocol")
			}

			return NetworkService(provider: provider) { tokenStorage.accessToken }
		}.inObjectScope(.container)

        container.register(CourtsRepositoryProtocol.self) { resolver in
            guard let service = resolver.resolve(NetworkServiceProtocol.self) else {
                fatalError("Error: Failed to resolve NetworkServiceProtocol")
            }

            return CourtsRepository(service: service)
        }.inObjectScope(.container)
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
