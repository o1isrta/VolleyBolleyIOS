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
        static let backgroundImageViewTopInset: CGFloat = -6
        static let backgroundImageViewWidth: CGFloat = 302
        static let backgroundImageViewHeight: CGFloat = 245
        static let spacing: CGFloat = 7
        static let vStackTopInset: CGFloat = 190
    }

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        return view
    }()

    private let contentView = UIView()

    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.Image.homeBackground
        view.contentMode = .topLeft
        return view
    }()

    private let backgroundImageFadeMaskLayer = CAGradientLayer()

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            createNewGameButton,
            findGameButton,
            hStackView
        ])
        view.axis = .vertical
        view.spacing = Constants.spacing
        return view
    }()

    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createTourneyButton, donateButton])
        view.axis = .horizontal
        view.spacing = Constants.spacing
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyBackgroundImageFadeMask()
    }

    // MARK: - Public Methods

    func displayCreateNewGameButton(state: CreateNewGameButtonState) {
        createNewGameButton.configure(state: state)
    }

    func displayFindGameButton(gamesCount: Int) {
        findGameButton.configure(with: gamesCount)
    }

    // MARK: - Private Methods

    private func applyBackgroundImageFadeMask() {
        let fadeHeight: CGFloat = 80

        let imageHeight = backgroundImageView.bounds.height
        guard imageHeight > 0 else { return }

        backgroundImageFadeMaskLayer.frame = backgroundImageView.bounds

        let startFadeLocation = max((imageHeight - fadeHeight) / imageHeight, 0)

        backgroundImageFadeMaskLayer.colors = [
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.clear.cgColor
        ]

        backgroundImageFadeMaskLayer.locations = [
            0.0,
            NSNumber(value: Float(startFadeLocation)),
            1.0
        ]

        backgroundImageView.layer.mask = backgroundImageFadeMaskLayer
    }

    private func setupView() {
        view.addSubviews(backgroundImageView, scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(vStackView)

        setupConstraintsScrollView()
        setupConstraintsContentView()
        setupConstraintsVStackView()
        setupConstraintsBackgroundImageView()
        setupConstraintsSketchButtons()
    }

    // MARK: - Constraints

    private func setupConstraintsScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 36)
        ])
    }

    private func setupConstraintsContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setupConstraintsVStackView() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.vStackTopInset
            ),
            vStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.spacing
            ),
            vStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.spacing
            ),
            vStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            )
        ])
    }

    private func setupConstraintsBackgroundImageView() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.backgroundImageViewTopInset
            ),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: Constants.backgroundImageViewHeight),
            backgroundImageView.widthAnchor.constraint(equalToConstant: Constants.backgroundImageViewWidth)
        ])
    }

    private func setupConstraintsSketchButtons() {
        NSLayoutConstraint.activate([
            createTourneyButton.heightAnchor.constraint(equalTo: createTourneyButton.widthAnchor),
            donateButton.heightAnchor.constraint(equalTo: donateButton.widthAnchor)
        ])
    }
}
