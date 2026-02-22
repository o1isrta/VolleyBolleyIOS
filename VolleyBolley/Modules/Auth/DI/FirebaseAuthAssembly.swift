//
//  FirebaseAuthAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.10.2025.
//

import Swinject

final class FirebaseAuthAssembly: Assembly {

	func assemble(container: Container) {
		container.register(FirebaseAuthServiceProtocol.self) { _ in
			FirebaseAuthService()
		}
	}
}
