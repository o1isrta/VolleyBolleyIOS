//
//  PhotoAction.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import Foundation

enum PhotoAction: Int, CaseIterable {
	case chooseFromGallery = 0
	case takePhoto = 1
	case deletePhoto = 2

	var icon: String {
		switch self {
		case .chooseFromGallery: return "photo"
		case .takePhoto: return "camera"
		case .deletePhoto: return "trash"
		}
	}

	var title: String {
		switch self {
		case .chooseFromGallery: return String(localized: "editProfilePhoto.action.chooseFromGallery")
		case .takePhoto: return String(localized: "editProfilePhoto.action.takePhoto")
		case .deletePhoto: return String(localized: "editProfilePhoto.action.deletePhoto")
		}
	}
}
