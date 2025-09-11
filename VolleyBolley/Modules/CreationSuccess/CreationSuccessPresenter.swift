//
//  CreationSuccessPresenter.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 11.09.2025.
//

import Foundation

enum CreationType {
    case game
    case tourney

    var titleText: String {
        switch self {
        case .game: return "Game created"
        case .tourney: return "Tourney created"
        }
    }
}

protocol CreationSuccessPresenterProtocol {
    var numberOfItems: Int { get }
    var titleText: String { get }
    func infoItem(at index: Int) -> CreationInfoItem
    func didTapDone()
    func didTapInvite()
    func didTapShare()
}

final class CreationSuccessPresenter: CreationSuccessPresenterProtocol {

    // MARK: - Internal Properties

    weak var view: CreationSuccessView?
    var numberOfItems: Int {
        infoItems.count
    }
    var titleText: String {
        creationType.titleText
    }

    // MARK: - Private Properties

    private let creationType: CreationType
    private let infoItems = [
        CreationInfoItem(type: .place, title: "Karon Beach Club", description: "Patak Rd, Mueang Phuket"),
        CreationInfoItem(type: .time, title: "Starts today", description: "2:00-3:00 pm"),
        CreationInfoItem(type: .level, title: "Level: Hard", description: "Mix · 4 teams"),
        CreationInfoItem(type: .price, title: "5$ per person", description: "988 016 7890")
    ]

    // MARK: - Initializers

    init(creationType: CreationType = .game) {
        self.creationType = creationType
    }

    // MARK: - Internal Methods

    func infoItem(at index: Int) -> CreationInfoItem {
        infoItems[index]
    }

    func didTapDone() {}

    func didTapInvite() {}

    func didTapShare() {}
}
