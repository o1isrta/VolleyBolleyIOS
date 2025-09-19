//
//  HomeViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func displayCreateNewGameButton(state: CreateNewGameButtonState)
    func displayFindGameButton(gamesCount: Int)
}

final class HomeViewController: BaseViewController, HomeViewProtocol {

    // MARK: - Private Properties

    private let presenter: HomePresenterProtocol
    private var createNewGameCourtId: Int?

    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.Image.homeBackground
        view.contentMode = .topLeft
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var topStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createNewGameButton, findGameButton])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createTourneyButton, donateButton])
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

    func displayCreateNewGameButton(state: CreateNewGameButtonState) {
        createNewGameButton.configure(state: state)
    }

    func displayFindGameButton(gamesCount: Int) {
        findGameButton.configure(with: gamesCount)
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)

        mainStackView.pinToSuperviewEdges(insets: .init(top: 284, left: 8, bottom: 100, right: 8))
        setupConstraintsBackgroundImageView()
    }

    // MARK: - Constraints

    private func setupConstraintsBackgroundImageView() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
