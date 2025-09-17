//
//  UseCasesAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Swinject

struct UseCasesAssembly: Assembly {

    private let assemblies: [Assembly] = [
        CourtsUseCaseAssembly(),
        GamesUseCaseAssembly()
    ]

    func assemble(container: Container) {
        assemblies.forEach { $0.assemble(container: container) }
    }
}
