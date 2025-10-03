//
//  ProfileViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
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

    var icon: UIImage {
        switch self {
        case .players: return UIImage.Icon.players
        case .personal: return UIImage.Icon.personal
        case .fluentPayment: return UIImage.Icon.fluentPayment
        case .support: return UIImage.Icon.support
        case .faq: return UIImage.Icon.tooltip
        case .about: return UIImage.Icon.about
        case .logOut: return UIImage.Icon.logOut
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

final class ProfileViewController: BaseViewController {

    // MARK: - Private Properties

    private let presenter: ProfilePresenterProtocol
    private lazy var menuItems = ProfileMenuItem.allCases

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
}

// MARK: - Public Methods

extension ProfileViewController: ProfileViewProtocol {

	func displayError(message: String) {
		print(message)
	}
}

// MARK: - Private methods

private extension ProfileViewController {

    func setupUI() {
		view.addSubviews(
			deleteButton,
			tableBackground,
			tableView
		)
    }

    func setupView() {
        setupUI()

        NSLayoutConstraint.activate([
			tableBackground.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
            tableBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableBackground.heightAnchor.constraint(equalToConstant: 400),

            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.heightAnchor.constraint(equalToConstant: 400),

            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
			deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
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
		cell.configure(
				icon: item.icon,
				title: item.title,
				isLast: isLast
			)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = menuItems[indexPath.row]
        presenter.didSelectMenuItem(item)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

#if DEBUG

// MARK: - Preview

import SwiftUI

struct ProfileViewControllerPreview: UIViewControllerRepresentable {
	class StubPresenter: ProfilePresenterProtocol {
		weak var view: ProfileViewProtocol?
		func viewDidLoad() {}
		func didSelectMenuItem(_ item: ProfileMenuItem) {}
	}

	func makeUIViewController(context: Context) -> some UIViewController {
		let presenter = StubPresenter()
		return ProfileViewController(presenter: presenter)
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ProfileViewController_Previews: PreviewProvider {
	static var previews: some View {
		ProfileViewControllerPreview()
			.edgesIgnoringSafeArea(.all)
	}
}
#endif
