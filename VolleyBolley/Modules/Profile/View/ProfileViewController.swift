//
//  ProfileViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func showGreeting(_ message: String)
    func displayError(message: String)
}

enum ProfileMenuItem: CaseIterable {
    case players
    case personal
    case fluentPayment
    case support
    case faq
    case about
    case logOut

    var icon: String {
        switch self {
        case .players: return "players"
        case .personal: return "personal"
        case .fluentPayment: return "fluent_payment"
        case .support: return "support"
        case .faq: return "tooltip"
        case .about: return "about"
        case .logOut: return "log_out"
        }
    }

    var title: String {
        switch self {
        case .players: return String(localized: "Players")
        case .personal: return String(localized: "Personal data")
        case .fluentPayment: return String(localized: "Payments")
        case .support: return String(localized: "Support")
        case .faq: return String(localized: "FAQ")
        case .about: return String(localized: "About")
        case .logOut: return String(localized: "Log out")
        }
    }
}

final class ProfileViewController: BaseViewController, ProfileViewProtocol {

    // MARK: - Private Properties

    private let presenter: ProfilePresenterProtocol

    private lazy var mainTabBarController = MainTabBarController()

    private lazy var menuItems = ProfileMenuItem.allCases

    private lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = AppFont.Quantex.regular(size: 16)
        return view
    }()

    private lazy var tableBackground = GlassmorphismView()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 32
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.menuCellIdentifier)
        return tableView
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized: "DELETE ACCOUNT"), for: .normal)
        button.setTitleColor(AppColor.Text.primary, for: .normal)
        button.titleLabel?.font = AppFont.Hero.light(size: 14)
        return button
    }()

    // MARK: - Initializers

    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
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

private extension ProfileViewController {

    func setupUI() {
		view.addSubviews(
			label,
			deleteButton,
			tableBackground,
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

			tableBackground.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
            tableBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableBackground.heightAnchor.constraint(equalToConstant: 400),

            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.heightAnchor.constraint(equalToConstant: 400),

            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            deleteButton.bottomAnchor.constraint(equalTo: mainTabBarController.view.topAnchor, constant: -20),

            mainTabBarController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTabBarController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTabBarController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTabBarController.view.heightAnchor.constraint(equalToConstant: 81)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MenuCell.menuCellIdentifier,
            for: indexPath) as? MenuCell else {
            return UITableViewCell()
        }
        let item = menuItems[indexPath.row]
        let isLast = indexPath.row == menuItems.count - 1
        cell.configure(iconName: item.icon, title: item.title, isLast: isLast)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
		// TODO:
        print("Tapped: \(menuItems[indexPath.row].title)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	class StubPresenter: ProfilePresenterProtocol {
		weak var view: ProfileViewProtocol?
		func viewDidLoad() {}
	}
	let presenter = StubPresenter()
	return ProfileViewController(presenter: presenter)
}
#endif
