//
//  СhoicePlayers.swift
//  VolleyBolley
//
//  Created by Вадим on 21.08.2025.
//

import UIKit

protocol СhoicePlayersViewProtocol: AnyObject {
    func showGreeting(_ message: String)
    func displayNavBar(viewModel: NavBarViewModel)
    func displayError(message: String)
}

final class СhoicePlayersViewController: BaseViewController, СhoicePlayersViewProtocol {

    // MARK: - Private Properties

    private var playersMock: [String] = [
        "Polina Vasilieva",
        "Kristina Popova",
        "Anton Ivanov",
        "Aleksandr Abramov"
    ]

    private let presenter: СhoicePlayersViewProtocol

    private lazy var navigationBarView = CustomNavBarView()
    private lazy var mainTabBarController = MainTabBarController()

    private lazy var buttonBack: UtilityButton = { // TODO: Если нужно было подругому переиспользовать, то подскажите
        let button = UtilityButton(style: .large)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        return button
    }()

    private lazy var titleLabel = CustomTitle(
        text: String(localized: "Private game"),
        isLarge: true
    )

    private lazy var searchBar: GradientSearchField = { // TODO: Другого SearchBar не нашел
        let view = GradientSearchField(type: .searchTeams)
        return view
    }()

    private lazy var segmentedControl: CustomSegmentedControl = {
        let view = CustomSegmentedControl(type: .players)
        return view
    }()

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

    private lazy var background: GlassmorphismView = {
        let view = GlassmorphismView()
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.playerCellidentifier)
        return tableView
    }()

    private lazy var actionButton: NextStepButton = {
        let button = NextStepButton(
            title: String(localized: "ADD SELECTED"),
            isActive: true,
            target: self,
            action: #selector(actionButtonTapped)
        )
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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func showGreeting(_ message: String) {
        label.text = message
    }

    func displayNavBar(viewModel: NavBarViewModel) {
        navigationBarView.configure(with: viewModel)
    }

    func displayError(message: String) {
        print(message)
    }

    // MARK: - Private methods

    @objc private func actionButtonTapped() {
        print("Сохранить игроков и перейти дальше")
    }
}

// MARK: - Private methods

private extension СhoicePlayersViewController {

    func setupUI() {
        [navigationBarView, label].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [background, buttonBack, titleLabel, searchAndSegmentStack, tableAndButtonStack].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        addChild(mainTabBarController)
        view.addSubview(mainTabBarController.view)
        mainTabBarController.didMove(toParent: self)
        mainTabBarController.view.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupView() {
        setupUI()

        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 106),

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            background.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 8),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            background.heightAnchor.constraint(equalToConstant: 412),

            buttonBack.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 20),
            buttonBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor),

            searchAndSegmentStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            searchAndSegmentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            searchAndSegmentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),

            tableAndButtonStack.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableAndButtonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            tableAndButtonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            tableAndButtonStack.heightAnchor.constraint(equalToConstant: 232),

            mainTabBarController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTabBarController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTabBarController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTabBarController.view.heightAnchor.constraint(equalToConstant: 81)
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
        cell.configure(name: playersMock[indexPath.section])
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

#if DEBUG
import SwiftUI

struct ChoicePlayersViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: СhoicePlayersViewProtocol {
        func showGreeting(_ message: String) {}
        func displayNavBar(viewModel: NavBarViewModel) {}
        func displayError(message: String) {}
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let presenter = StubPresenter()
        return СhoicePlayersViewController(presenter: presenter)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ChoicePlayersViewController_Previews: PreviewProvider {
    static var previews: some View {
        ChoicePlayersViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
