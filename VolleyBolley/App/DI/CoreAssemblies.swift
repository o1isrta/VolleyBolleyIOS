//
//  CoreAssemblies.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject
import UIKit

enum CoreAssemblies {
    static func all(window: UIWindow) -> [Assembly] {
        return [
            WindowAssembly(window: window),
            AppRouterAssembly(),
            EnvironmentAssembly(),
            SettingsAssembly(),
            NetworkModulesAssembly(),
            MediaServicesAssembly(),
            LocationAssembly(),
            SessionAssembly(),
            GoogleAuthAssembly(),
            FirebaseAuthAssembly()
        ]
    }
}
