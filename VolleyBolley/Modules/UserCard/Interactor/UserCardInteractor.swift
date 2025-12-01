//
//  UserCardInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 13.11.2025.
//

import UIKit

protocol UserCardInteractorProtocol {
	func setAsFavorite(_ isFavorite: Bool)
	func loadAvatar(by url: URL?) -> UIImage?
}

final class UserCardInteractor: UserCardInteractorProtocol {

	// MARK: - Public Methods

	func setAsFavorite(_ isFavorite: Bool) {
		// TODO: - шлем запрос
		print("шлем запрос -> setAsFavorite", isFavorite)
	}

	func loadAvatar(by url: URL?) -> UIImage? {
		// TODO: - тут грузим аватар
		print("loadAvatar by", url)
		return .imgPerson
		guard let url else { return nil }
	}
}
