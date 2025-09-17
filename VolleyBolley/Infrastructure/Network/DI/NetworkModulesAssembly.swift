//
//  NetworkModulesAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Swinject

struct NetworkModulesAssembly: Assembly {

    private let assemblies: [Assembly] = [
        PlayersNetworkAssembly(),
        CourtsNetworkAssembly(),
        GamesNetworkAssembly()
    ]

    func assemble(container: Container) {
        assemblies.forEach { $0.assemble(container: container) }
    }
}
