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
		// Registering the token storage
		container.register(TokenStorageProtocol.self) { _ in
			TokenStorage.shared
		}.inObjectScope(.container)
		// Registering NetworkService with DI token
		container.register(NetworkServiceProtocol.self) { resolver in
			guard let tokenStorage = resolver.resolve(TokenStorageProtocol.self) else {
				fatalError("Error: Failed to resolve TokenStorageProtocol")
			}

			let plugins: [PluginType] = [
				NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
			]
			let stubClosure: (DataAPI) -> StubBehavior = NetworkEnvironment.current.useStubbedProvider
				? { _ in .immediate }
				: MoyaProvider.neverStub

			let provider = MoyaProvider<DataAPI>(stubClosure: stubClosure, plugins: plugins)
			return NetworkService(provider: provider) { tokenStorage.accessToken }
		}.inObjectScope(.container)
	}
}
