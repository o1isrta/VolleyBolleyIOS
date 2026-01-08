//
//  SketchButtonType.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.11.2025.
//

import UIKit

enum SketchButtonType: CaseIterable {
	case createTourney
	case donate
	case invitePlayers
	case shareLink
	case sendInvites
	case saveGame

	var title: String {
		switch self {
		case .createTourney: return String(localized: "sketchButton.createTourney")
		case .donate: return String(localized: "sketchButton.donate")
		case .invitePlayers: return String(localized: "sketchButton.invitePlayers")
		case .shareLink: return String(localized: "sketchButton.shareLink")
		case .sendInvites: return String(localized: "sketchButton.sendInvites")
		case .saveGame: return String(localized: "sketchButton.saveGame")
		}
	}

	var image: UIImage? {
		switch self {
		case .createTourney: return UIImage.Icon.createTourney
		case .donate: return UIImage.Icon.donate
		case .invitePlayers: return UIImage.Icon.invitePlayers
		case .shareLink: return UIImage.Icon.share
		case .sendInvites: return UIImage.Icon.sendInvites
		case .saveGame: return UIImage.Icon.saveGame
		}
	}
}
