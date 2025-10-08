//
//  СhoicePlayersViewController.swift
//  VolleyBolley
//
//  Created by Вадим on 21.08.2025.
//

import UIKit

protocol СhoicePlayersViewProtocol: AnyObject {
    func showGreeting(_ message: String)
    func displayError(message: String)
}

final class СhoicePlayersViewController: BaseViewController, СhoicePlayersViewProtocol {

    // MARK: - Private Properties

	// TODO: remove it in the future
    private var playersMock: [Player] = PlayersMock.players
    private var favoritePlayers: Set<String> = []

    private let presenter: СhoicePlayersViewProtocol

    private lazy var searchBar = GradientSearchField(type: .searchTeams)
    private lazy var segmentedControl = CustomSegmentedControl(type: .players)

    private lazy var buttonBack: UtilityButton = {
        let button = UtilityButton(style: .large)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        return button
    }()

    private lazy var titleLabel = CustomTitle(
        text: String(localized: "Private game"),
        isLarge: true
    )

    private lazy var searchAndSegmentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchBar, segmentedControl])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()

    private lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = AppFont.Quantex.regular(size: 16)
        return view
    }()

    private lazy var background = GlassmorphismView()

    private lazy var tableView: UITableView = {
        let tableView = IntrinsicTableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.playerCellidentifier)
        return tableView
    }()

    private lazy var actionButton: YellowButton = {
        let button = YellowButton(title: String(localized: "ADD SELECTED"))
        button.isSelected = true
        button.isEnabled = true
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var tableAndButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tableView, actionButton])
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()

    // MARK: - Initializers

    init(presenter: СhoicePlayersViewProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
		hideKeyboardWhenTappedAround()
    }

    // MARK: - Public Methods

    func showGreeting(_ message: String) {
        label.text = message
    }

    func displayError(message: String) {
        print(message)
    }

    // MARK: - Private methods

    @objc private func actionButtonTapped() {
		// TODO: Надо потом доработать логику кнопки
        print("Сохранить игроков и перейти дальше")
    }
}

// MARK: - Private methods

private extension СhoicePlayersViewController {

    func setupUI() {
		view.addSubviews(
			label,
			background,
			buttonBack,
			titleLabel,
			searchAndSegmentStack,
			tableAndButtonStack
		)
    }

    func setupView() {
        setupUI()

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

			background.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            background.bottomAnchor.constraint(equalTo: tableAndButtonStack.bottomAnchor, constant: 20),

			buttonBack.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20),
            buttonBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor),

            searchAndSegmentStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            searchAndSegmentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            searchAndSegmentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),

            actionButton.heightAnchor.constraint(equalToConstant: 44),

            tableAndButtonStack.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableAndButtonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            tableAndButtonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
}

// MARK: - UITableViewDataSource

extension СhoicePlayersViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return playersMock.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlayerCell.playerCellidentifier,
            for: indexPath) as? PlayerCell else {
            return UITableViewCell()
        }
        let player = playersMock[indexPath.section]
        let fullName = "\(player.firstName) \(player.lastName)"
        let isFavorite = favoritePlayers.contains(fullName)
        cell.configure(with: PlayerCellModel(
            name: fullName,
            isFavorite: isFavorite,
            isSelected: false
        ))
        cell.onFavoriteToggle = { [weak self] in
            guard let self else { return }
            if self.favoritePlayers.contains(fullName) {
                self.favoritePlayers.remove(fullName)
            } else {
                self.favoritePlayers.insert(fullName)
            }
            print("Избранные: \(self.favoritePlayers)")
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension СhoicePlayersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 23
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == playersMock.count - 1 ? 0 : 24
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	class StubPresenter: СhoicePlayersViewProtocol {
		func showGreeting(_ message: String) {}
		func displayError(message: String) {}
	}
	let presenter = StubPresenter()
	return СhoicePlayersViewController(presenter: presenter)
}
#endif
