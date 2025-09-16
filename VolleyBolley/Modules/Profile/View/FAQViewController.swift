//
//  FAQViewController.swift
//  VolleyBolley
//
//  Created by Вадим on 02.09.2025.
//

import UIKit

protocol FAQViewProtocol: AnyObject {
    func showGreeting(_ message: String)
    func displayError(message: String)
}

enum FAQItem: CaseIterable {
    case registration
    case postGameRatings
    case moveToNextCategory
    case levelDrop
    case fairPlayPolicy

    var title: String {
        switch self {
        case .registration:
            return String(localized: "Registration")
        case .postGameRatings:
            return String(localized: "Post-Game Ratings")
        case .moveToNextCategory:
            return String(localized: "Want to move to the next category?")
        case .levelDrop:
            return String(localized: "Levels can drop due to:")
        case .fairPlayPolicy:
            return String(localized: "Fair Play Policy")
        }
    }

    var subtitle: String {
        switch self {
        case .registration:
            return String(localized: """
            To find the right games and teammates, choose your current skill level:
            Options:
              • Light (L1–L3) – Beginner
              • Medium (M1–M3) – Confident amateur
              • Hard (H1–H3) – Advanced
              • Pro (P1–P3) – Professional
            The higher the number, the higher the skill. Your level may change later based on player ratings.
            """)
        case .postGameRatings:
            return String(localized: """
            After each game, teammates can rate your level.
            Once you receive 6 ratings, your level may change:
              • 5+ positive ratings → promoted one step
              • 5+ negative ratings → demoted one step
              • Mixed feedback → level stays the same
            """)
        case .moveToNextCategory:
            return String(localized: """
            Earn 10 points from higher-level players within the last 60 days.
            The higher the evaluator’s level, the more weight their rating carries.
            """)
        case .levelDrop:
            return String(localized: """
            Ratings (6 within 60 days, 5+ down = demotion)
            Inactivity:
            • 90 days = minus 1 step
            • 180 days = reset to lowest level in current category
            """)
        case .fairPlayPolicy:
            return String(localized: """
            We ensure a fair system:
            • Ratings are anonymous
            • Max 2 ratings from the same player in 60 days
            • Light has minimal impact on Hard and Pro levels
            • Pro levels are harder to reach
            Play fair — your level will speak for itself.
            """)
        }
    }
}

final class FAQViewController: BaseViewController, СhoicePlayersViewProtocol {

    // MARK: - Private Properties

    private let presenter: FAQViewProtocol

    private var faqItems: [FAQItem] = FAQItem.allCases

    private lazy var mainTabBarController = MainTabBarController()

    private lazy var buttonBack: UtilityButton = {
        let button = UtilityButton(style: .large)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        return button
    }()

    private lazy var titleLabel = CustomTitle(
        text: String(localized: "FAQ"),
        isLarge: true
    )

    private lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = AppFont.Quantex.regular(size: 16)
        return view
    }()

    private lazy var background: GlassmorphismView = {
        let view = GlassmorphismView()
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.dataSource = self
        tableView.register(FAQCell.self, forCellReuseIdentifier: FAQCell.faqId)
        return tableView
    }()

    // MARK: - Initializers

    init(presenter: FAQViewProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func showGreeting(_ message: String) {
        label.text = message
    }

    func displayError(message: String) {
        print(message)
    }
}

// MARK: - Private methods

private extension FAQViewController {

    func setupUI() {
		view.addSubviews(
			label,
			background,
			buttonBack,
			titleLabel,
			tableView
		)

        addChild(mainTabBarController)
        view.addSubview(mainTabBarController.view)
        mainTabBarController.didMove(toParent: self)
        mainTabBarController.view.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupView() {
        setupUI()

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

			background.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            background.bottomAnchor.constraint(equalTo: mainTabBarController.view.topAnchor, constant: -8),

            buttonBack.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20),
            buttonBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor),

            tableView.topAnchor.constraint(equalTo: background.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -20),

            mainTabBarController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTabBarController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTabBarController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTabBarController.view.heightAnchor.constraint(equalToConstant: 81)
        ])
    }
}

// MARK: - UITableViewDataSource

extension FAQViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        faqItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FAQCell.faqId,
            for: indexPath) as? FAQCell else {
            return UITableViewCell()
        }
        let item = faqItems[indexPath.row]
        cell.configure(with: item, isLast: indexPath.row == faqItems.count - 1)
        return cell
    }
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	class StubPresenter: FAQViewProtocol {
		func showGreeting(_ message: String) {}
		func displayError(message: String) {}
	}
	let presenter = StubPresenter()
	return FAQViewController(presenter: presenter)
}
#endif
