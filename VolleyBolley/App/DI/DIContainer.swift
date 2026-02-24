//
//  DIContainer.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

final class DIContainer {

	// MARK: - Public Properties

	let assembler: Assembler

	var resolver: Resolver { assembler.resolver }

	// MARK: - Initializers

	init(window: UIWindow) {
		assembler = Assembler(
			[
				CoreAssemblies.all(window: window),
				FeatureAssemblies.all
			].flatMap { $0 }
		)
	}
}
