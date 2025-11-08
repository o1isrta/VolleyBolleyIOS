//
//  HomeViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

@MainActor
protocol HomeViewProtocol: AnyObject {
    func displayCreateNewGameButton(state: CreateNewGameButtonState)
    func displayFindGameButton(gamesCount: Int)
}

final class HomeViewController: BaseViewController, HomeViewProtocol {

    // MARK: - Private Properties

    private let presenter: HomePresenterProtocol
    private var createNewGameCourtId: Int?

    private enum Constants {
        static let backgroundTop: CGFloat = 100
        static let backgroundWidth: CGFloat = 302.scaledByScreenHeight
        static let backgroundHeight: CGFloat = 285.scaledByScreenHeight
        static let vStackSpacing: CGFloat = 8.scaledByScreenHeight
        static let hStackSpacing: CGFloat = 8.scaledByScreenWidth
        static let sideInset: CGFloat = 8.scaledByScreenWidth
        static let topInset: CGFloat = 284.scaledByScreenHeight
        static let sketchButtonHeight: CGFloat = 180.scaledByScreenHeight
        static let createGameButtonHeight: CGFloat = 116.scaledByScreenHeight
        static let findGameButtonHeight: CGFloat = 114.scaledByScreenHeight
    }

    private let backgroundImageView = UIImageView(image: UIImage.Image.homeBackground)

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            createNewGameButton,
            findGameButton,
            hStackView
        ])
        view.axis = .vertical
        view.spacing = Constants.vStackSpacing
        return view
    }()

    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createTourneyButton, donateButton])
        view.axis = .horizontal
        view.spacing = Constants.hStackSpacing
        view.distribution = .fillEqually
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
		let view = SketchButton(type: .createTourney, isSelected: true)
        view.addAction(UIAction { [weak self] _ in
             self?.presenter.didTapCreateTourney()
        }, for: .touchUpInside)
        return view
    }()

    private lazy var donateButton: SketchButton = {
		let view = SketchButton(type: .donate)
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
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter.viewDidLoad()
    }

    // MARK: - Public Methods

    func displayCreateNewGameButton(state: CreateNewGameButtonState) {
        createNewGameButton.configure(state: state)
    }

    func displayFindGameButton(gamesCount: Int) {
        findGameButton.configure(with: gamesCount)
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubviews(backgroundImageView, vStackView)

        setupConstraintsMainStackView()
        setupConstraintsBackgroundImageView()
        setupButtonHeights()
    }

    // MARK: - Constraints

    private func setupConstraintsMainStackView() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topInset),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideInset),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideInset)
        ])
    }

    private func setupConstraintsBackgroundImageView() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        guard let image = backgroundImageView.image else {
            NSLayoutConstraint.activate([
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.backgroundTop),
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.widthAnchor.constraint(equalToConstant: Constants.backgroundWidth),
                backgroundImageView.heightAnchor.constraint(equalToConstant: Constants.backgroundHeight)
            ])
            return
        }

        let aspectRatio = image.size.height / image.size.width

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.backgroundTop),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: Constants.backgroundWidth),
            backgroundImageView.heightAnchor.constraint(
                equalTo: backgroundImageView.widthAnchor,
                multiplier: aspectRatio
            )
        ])
    }

    private func setupButtonHeights() {
        NSLayoutConstraint.activate([
            createNewGameButton.heightAnchor.constraint(equalToConstant: Constants.createGameButtonHeight),
            findGameButton.heightAnchor.constraint(equalToConstant: Constants.findGameButtonHeight),
            createTourneyButton.heightAnchor.constraint(equalToConstant: Constants.sketchButtonHeight),
            donateButton.heightAnchor.constraint(equalToConstant: Constants.sketchButtonHeight)
        ])
    }
}
