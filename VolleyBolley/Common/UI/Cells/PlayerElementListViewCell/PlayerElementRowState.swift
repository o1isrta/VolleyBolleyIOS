//
//  PlayerElementRowState.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.01.2026.
//

import Foundation

enum PlayerElementRowState {
	case numbered(player: PlayerElementListViewCellModel)
	case numberedWithAction(player: PlayerElementListViewCellModel, deleteAction: (() -> Void))
	case numberedFreeSpot(index: Int)
	case plain(player: PlayerElementListViewCellModel)
	case plainWithAction(player: PlayerElementListViewCellModel, deleteAction: (() -> Void))
	case plainFreeSpot
}
