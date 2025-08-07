//
//  ProfileViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func showGreeting(_ message: String)
    func displayNavBar(viewModel: NavBarViewModel)
    func displayError(message: String)
}

final class ProfileViewController: BaseViewController, ProfileViewProtocol {

    // MARK: - Private Properties

    private let presenter: ProfilePresenterProtocol

    private lazy var navigationBarView = CustomNavBarView()
    private lazy var mainTabBarController = MainTabBarController()

    private lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = AppFont.Quantex.regular(size: 16)
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.layer.cornerRadius = 32
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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    func displayNavBar(viewModel: NavBarViewModel) {
        navigationBarView.configure(with: viewModel)
    }

    func displayError(message: String) {
        print(message)
    }
}

// MARK: - Constants

private extension ProfileViewController {
    func setupUI() {
        [navigationBarView, label, tableView, deleteButton].forEach {
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

            tableView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 8),
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

#if DEBUG
import SwiftUI

struct ProfileViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: ProfilePresenterProtocol {
        weak var view: ProfileViewProtocol?
        func viewDidLoad() {}
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
