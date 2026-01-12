//
//  InvitePlayersListType.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.01.2026.
//

import Foundation

enum InvitePlayersListType {
	case privateGame
	case regular

	var title: String {
		switch self {
		case .privateGame:
			return String(localized: "invitePlayers.title.privateGame")
		case .regular:
			return String(localized: "invitePlayers.title.regular")
		}
	}

	var actionButtonTitle: String {
		switch self {
		case .privateGame:
			return String(localized: "invitePlayers.action.addSelectedPlayers")
		case .regular:
			return String(localized: "invitePlayers.action.inviteSelectedPlayers")
		}
	}
}
