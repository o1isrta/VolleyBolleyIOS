//
//  BaseNetworkAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.09.2025.
//

import Moya
import Swinject

protocol BaseNetworkAssembly: Assembly {}

extension BaseNetworkAssembly {

    // MARK: - Provider

    func registerMoyaProvider<T: TargetType>(
        _ type: T.Type,
        container: Container
    ) {
        container.register(MoyaProvider<T>.self) { resolver in
            guard let environment = resolver.resolve(AppEnvironment.self) else {
                fatalError("[DI Error] AppEnvironment is not resolved")
            }

            return MoyaProvider<T>(
                endpointClosure: self.makeEndpointClosure(environment: environment),
                stubClosure: self.makeStubClosure(environment: environment),
                plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
            )
        }
        .inObjectScope(.container)
    }

    // MARK: - Service

    func registerService<Service: ProviderInitializable, Protocol, Target: TargetType>(
        _ serviceType: Service.Type,
        protocolType: Protocol.Type,
        providerType: Target.Type,
        container: Container
    ) where Service.ProviderType == MoyaProvider<Target> {
        container.register(protocolType) { resolver in
            guard let provider = resolver.resolve(MoyaProvider<Target>.self) else {
                fatalError("[DI Error] Failed to resolve MoyaProvider<\(Target.self)>")
            }

            guard let service = serviceType.init(provider: provider) as? Protocol else {
                fatalError("[DI Error] Failed to initialize service \(Service.self)")
            }

            return service
        }
        .inObjectScope(.container)
    }

    // MARK: - Repository

    func registerRepository<Repository: ServiceInitializable, Protocol, ServiceProtocol>(
        _ repositoryType: Repository.Type,
        protocolType: Protocol.Type,
        serviceType: ServiceProtocol.Type,
        container: Container
    ) where Repository.ServiceType == ServiceProtocol {
        container.register(protocolType) { resolver in
            guard let service = resolver.resolve(ServiceProtocol.self) else {
                fatalError("[DI Error] Failed to resolve service \(ServiceProtocol.self)")
            }

            guard let repository = repositoryType.init(service: service) as? Protocol else {
                fatalError("[DI Error] Failed to initialize repository \(Repository.self)")
            }

            return repository
        }
        .inObjectScope(.container)
    }

    // MARK: - Helpers

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
