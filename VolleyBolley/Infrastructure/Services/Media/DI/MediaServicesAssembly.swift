//
//  MediaServicesAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Swinject

final class MediaServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ImageLoadingServiceProtocol.self) { _ in
            KingfisherImageLoadingService()
        }
        .inObjectScope(.container)
    }
}
