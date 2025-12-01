//
//  Resolver+SafeResolve.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 22.10.2025.
//

import Swinject

extension Resolver {
    func safeResolve<Service>(
        _ serviceType: Service.Type,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Service {
        guard let service = resolve(serviceType) else {
            fatalError("❌ Failed to resolve \(serviceType) in \(file):\(line)")
        }
        return service
    }
}
