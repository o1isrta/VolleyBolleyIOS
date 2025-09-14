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
        case .game: return NSLocalizedString("game.created", comment: "")
        case .tourney: return NSLocalizedString("tourney.created", comment: "")
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

    func didTapInvite() {
        interactor.fetchInviteLink { [weak self] link in
            guard let link else { return }
            self?.router.openShareSheet(with: link)
        }
    }

    func didTapShare() {
        router.openShareSheet(with: "")
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
            startTitle = "Starts today"
        } else if calendar.isDateInTomorrow(info.startTime) {
            startTitle = "Starts tomorrow"
        } else {
            startTitle = "Starts on \(AppDateFormatters.onlyDate.string(from: info.startTime))"
        }

        let capitalizedLevels = info.levels.map { $0.capitalizingFirstLetter() }
        let levelDescription = NSLocalizedString(
            "Level",
            comment: ""
        ) + ": " + capitalizedLevels.joined(separator: ", ")

        let details: String
        if let gameInfo = info as? GameCreationInfo {
            var desc = "\(gameInfo.gender.capitalizingFirstLetter()) · \(gameInfo.maximumPlayers) players"
            if gameInfo.isPrivate {
                desc += " · private game"
            }
            details = desc
        } else if let tourneyInfo = info as? TourneyCreationInfo {
            details = "\(tourneyInfo.gender.capitalizingFirstLetter()) · \(tourneyInfo.maximumTeams) teams"
        } else {
            details = ""
        }

        infoItems = [
            CreationInfoItem(type: .place, title: info.courtName, description: info.locationName),
            CreationInfoItem(type: .time, title: startTitle, description: timeRange),
            CreationInfoItem(type: .level, title: levelDescription, description: details),
            CreationInfoItem(
                type: .price,
                title: "\(info.pricePerPerson)$ per person",
                description: info.paymentAccount
            )
        ]
    }
}
