//
//  HomeViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showGreeting(_ message: String)
    func displayNavBar(viewModel: NavBarViewModel)
    func displayError(message: String)
}

final class HomeViewController: BaseViewController, HomeViewProtocol {

    // MARK: - Private Properties

    private let presenter: HomePresenterProtocol

    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = .bgHomeScreen
        view.contentMode = .topLeft
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    private lazy var createGameButton: CreateGameButton = {
//        let view = CreateGameButton()
//        view.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
//        return view
//    }()

    private lazy var navigationBarView: CustomNavBarView = {
        let view = CustomNavBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var topStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var createNewGameButton: AppButtonActionView = {
        let view = AppButtonActionView(.invitePlayers)
        view.setAction(self.didTapCreateNewGameButton)
        return view
    }()

    private lazy var findGameButton: AppButtonActionView = {
        let view = AppButtonActionView(.saveGame)
        view.setAction(self.didTapFindGameButton)
        return view
    }()

    private lazy var createTourneyButton: AppButtonActionView = {
        let view = AppButtonActionView(.createTourney)
        view.isSelected = true
        view.setAction(self.didTapCreateTourneyButton)
        return view
    }()

    private lazy var donateButton: AppButtonActionView = {
        let view = AppButtonActionView(.donate)
        view.setAction(self.didTapDonateButton)
        return view
    }()

    // MARK: - Initializers

    init(presenter: HomePresenterProtocol) {
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
        print(message)
    }

    func displayNavBar(viewModel: NavBarViewModel) {
        navigationBarView.configure(with: viewModel)
    }

    func displayError(message: String) {
        print(message)
    }

    // MARK: - Private Methods

    private func didTapCreateNewGameButton(_ button: AppButtonActionView) {
        print("CreateNewGame button tapped")
    }

    private func didTapFindGameButton(_ button: AppButtonActionView) {
        print("FindGame button tapped")
    }

    private func didTapCreateTourneyButton(_ button: AppButtonActionView) {
        print("CreateTourney button tapped")
    }

    private func didTapDonateButton(_ button: AppButtonActionView) {
        print("Donate button tapped")
    }

    private func setupView() {
        view.addSubview(navigationBarView)
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)

        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(bottomStackView)

        [createNewGameButton, findGameButton].forEach {
            topStackView.addArrangedSubview($0)
        }

        [createTourneyButton, donateButton].forEach {
            bottomStackView.addArrangedSubview($0)
        }

        setupLayout()
    }

    private func setupLayout() {
        setupConstraintsNavBar()
        setupConstraintsBackgroundImageView()
        setupConstraintsVStackView()
        setupConstraintsBottomButtonViews()
    }

    // MARK: - Constraints

    private func setupConstraintsNavBar() {
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 106)
        ])
    }

    private func setupConstraintsBackgroundImageView() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 297),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }

    private func setupConstraintsVStackView() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 178),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }

    private func setupConstraintsBottomButtonViews() {
        [createTourneyButton, donateButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 180).isActive = true
        }
    }

//    private func setupConstraintsCreateGameButton() {
//        NSLayoutConstraint.activate([
//            createGameButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 285),
//            createGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            createGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
//        ])
//    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
    UIViewControllerPreview {
        HomeModulePreviewBuilder.build()
    }
    .edgesIgnoringSafeArea(.all)
}
#endif
