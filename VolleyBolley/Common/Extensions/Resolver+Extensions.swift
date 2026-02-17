//
//  Resolver+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.02.2026.
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
