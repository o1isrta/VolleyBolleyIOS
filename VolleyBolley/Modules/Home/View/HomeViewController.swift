//
//  HomeViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

@MainActor
protocol HomeViewProtocol: AnyObject {
    func displayNavBar(viewModel: NavBarViewModel)
    func displayCreateNewGameButton(state: CreateNewGameButtonState)
}

final class HomeViewController: BaseViewController, HomeViewProtocol {

    // MARK: - Private Properties

    private let presenter: HomePresenterProtocol

    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.Image.homeBackground
        view.contentMode = .topLeft
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

    private lazy var createNewGameButton: CreateNewGameButton = {
        let view = CreateNewGameButton()
        view.addAction(UIAction { [weak self] _ in
             self?.presenter.didTapCreateNewGame()
        }, for: .touchUpInside)
        return view
    }()

    private lazy var findGameButton: FindGameButton = {
        let view = FindGameButton()
        view.addAction(UIAction { [weak self] _ in
             self?.presenter.didTapFindGame()
        }, for: .touchUpInside)
        return view
    }()

    private lazy var createTourneyButton: SketchButton = {
        let view = SketchButton()
        view.isSelected = true
        view.setTitle(String(localized: .commonCreateTourney), for: .normal)
        view.setImage(UIImage.Icon.createTourney, for: .normal)
        view.addAction(UIAction { [weak self] _ in
             self?.presenter.didTapCreateTourney()
        }, for: .touchUpInside)
        return view
    }()

    private lazy var donateButton: SketchButton = {
        let view = SketchButton()
        view.setTitle(String(localized: .commonDonate), for: .normal)
        view.setImage(UIImage.Icon.donate, for: .normal)
        view.addAction(UIAction { [weak self] _ in
            self?.presenter.didTapDonate()
        }, for: .touchUpInside)
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

    func displayNavBar(viewModel: NavBarViewModel) {
        navigationBarView.configure(with: viewModel)
    }

    func displayCreateNewGameButton(state: CreateNewGameButtonState) {
        createNewGameButton.configure(state: state)
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(backgroundImageView)
        view.addSubview(navigationBarView)
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
        setupConstraintsBackgroundImageView()
        setupConstraintsNavBar()
        setupConstraintsVStackView()
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
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor)
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
