//
//  NetworkAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Moya
import Swinject

protocol ProviderInitializable {
    associatedtype ProviderType
    init(provider: ProviderType)
}

protocol ServiceInitializable {
    associatedtype ServiceType
    init(service: ServiceType)
}

struct NetworkAssembly: Assembly {

    private let assemblies: [Assembly] = [
        PlayersAssembly(),
        CourtsAssembly()
    ]

    func assemble(container: Container) {
        assemblies.forEach { $0.assemble(container: container) }
    }
}
