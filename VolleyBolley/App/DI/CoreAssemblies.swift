//
//  CoreAssemblies.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.09.2025.
//

import Swinject
import UIKit

enum CoreAssemblies {
    static func all(window: UIWindow) -> [Assembly] {
        return [
            WindowAssembly(window: window),
            RouterAssembly(),
            EnvironmentAssembly(),
            SettingsStorageAssembly(),
            TokenStorageAssembly(),
            UserSessionAssembly(),
            NetworkModulesAssembly(),
            MediaServicesAssembly(),
            LocationAssembly(),
            DistanceAssembly(),
            DomainAssembly()
        ]
    }
}
