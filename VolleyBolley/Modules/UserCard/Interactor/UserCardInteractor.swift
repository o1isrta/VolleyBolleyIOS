//
//  UserCardInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 13.11.2025.
//

import Foundation

protocol UserCardInteractorProtocol {
	func setAsFavorite(_ isFavorite: Bool)
}

final class UserCardInteractor: UserCardInteractorProtocol {

	// MARK: - Public Methods

	func setAsFavorite(_ isFavorite: Bool) {
		// TODO: - шлем запрос
		print("шлем запрос -> setAsFavorite", isFavorite)
	}
}
