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
        case .game: return String(localized: "game.created")
        case .tourney: return String(localized: "tourney.created")
        }
    }
}

protocol CreationSuccessPresenterProtocol {
    var numberOfItems: Int { get }
    var titleText: String { get }
    func viewDidLoad()
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
        type.titleText
    }

    // MARK: - Private Properties

    private let interactor: CreationSuccessInteractorProtocol
    private let router: CreationSuccessRouterProtocol
    private let type: CreationType

    private var infoItems: [CreationInfoItem] = []

    // MARK: - Initializers

    init(
        interactor: CreationSuccessInteractorProtocol,
        router: CreationSuccessRouterProtocol,
        type: CreationType = .game
    ) {
        self.interactor = interactor
        self.router = router
        self.type = type
    }

    // MARK: - Internal Methods

    func viewDidLoad() {
        loadCreationInfo()
    }

    func infoItem(at index: Int) -> CreationInfoItem {
        infoItems[index]
    }

    func didTapDone() {
        router.closeScreen()
    }

    func didTapInvite() {}

    func didTapShare() {
        interactor.fetchInviteLink { [weak self] link in
            guard let link else { return }
            self?.router.openShareSheet(with: link)
        }
    }

    // MARK: - Private Methods

    private func loadCreationInfo() {
        interactor.fetchCreationInfo { [weak self] result in
            switch result {
            case .success(let info):
                self?.mapCreationInfoToItems(info)
                self?.view?.reloadData()
            case .failure(let error):
                self?.view?.showError(error)
            }
        }
    }

    private func mapCreationInfoToItems(_ info: CreationInfo) {
        let calendar = Calendar.current

        let startTimeText = AppDateFormatters.time12Hour.string(from: info.startTime)
        let endTimeText = AppDateFormatters.time12Hour.string(from: info.endTime).lowercased()

        let amPmRegex = try? NSRegularExpression(pattern: " [AP]M$", options: [])
        let startRange = NSRange(location: 0, length: startTimeText.utf16.count)
        let startWithoutAmPm = amPmRegex?.stringByReplacingMatches(
            in: startTimeText,
            options: [],
            range: startRange,
            withTemplate: ""
        ) ?? startTimeText

        let timeRange = "\(startWithoutAmPm)-\(endTimeText)"

        let startTitle: String
        if calendar.isDateInToday(info.startTime) {
            startTitle = String(localized: "creation.starts.today")
        } else if calendar.isDateInTomorrow(info.startTime) {
            startTitle = String(localized: "creation.starts.tomorrow")
        } else {
            startTitle = String(
                format: String(localized: "creation.starts.on"),
                AppDateFormatters.onlyDate.string(from: info.startTime)
            )
        }

        let capitalizedLevels = info.levels.map { $0.capitalizingFirstLetter() }
        let levelDescription = String(localized: "creation.level") + ": " + capitalizedLevels.joined(separator: ", ")

        var details: String
        if let gameInfo = info as? GameCreationInfo {
            var desc = String(
                format: String(localized: "creation.players"),
                gameInfo.maximumPlayers
            )
            desc = "\(gameInfo.gender.capitalizingFirstLetter()) · \(desc)"
            if gameInfo.isPrivate {
                desc += " · " + String(localized: "creation.privateGame")
            }
            details = desc
        } else if let tourneyInfo = info as? TourneyCreationInfo {
            details = String(
                format: String(localized: "creation.teams"),
                tourneyInfo.maximumTeams
            )
            details = "\(tourneyInfo.gender.capitalizingFirstLetter()) · \(details)"
        } else {
            details = ""
        }

        let priceTitle = String(
            format: String(localized: "creation.price"),
            "\(info.pricePerPerson)$"
        )

        infoItems = [
            CreationInfoItem(type: .place, title: info.courtName, description: info.locationName),
            CreationInfoItem(type: .time, title: startTitle, description: timeRange),
            CreationInfoItem(type: .level, title: levelDescription, description: details),
            CreationInfoItem(type: .price, title: priceTitle, description: info.paymentAccount)
        ]
    }
}
