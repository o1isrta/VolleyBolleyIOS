//
//  HomeViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeViewProtocol: AnyObject where Self: UIViewController {
    func displayCreateNewGameButton(state: CreateNewGameButtonState)
}

final class HomeViewController: BaseViewController, HomeViewProtocol {

    // MARK: - Private Properties

    private let presenter: HomePresenterProtocol
    private var createNewGameCourtId: Int?

    private enum Constants {
        static let verticalStackSpacing: CGFloat = 8
        static let horizontalStackSpacing: CGFloat = 8
        static let contentInsets = UIEdgeInsets(top: 284, left: 8, bottom: 100, right: 8)
    }

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
        view.axis = .vertical
        view.spacing = Constants.verticalStackSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var topStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createNewGameButton, findGameButton])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = Constants.horizontalStackSpacing
        return view
    }()

    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [createTourneyButton, donateButton])
        view.axis = .horizontal
        view.spacing = Constants.horizontalStackSpacing
        view.distribution = .fillEqually
        return view
    }()

    private lazy var createNewGameButton: SketchButton = {
        let view = SketchButton()
        view.setTitle("Create a game", for: .normal)
        view.addAction(UIAction { [weak self] _ in
             self?.presenter.didTapCreateNewGame()
        }, for: .touchUpInside)
        return view
    }()

    private lazy var findGameButton: SketchButton = {
        let view = SketchButton()
        view.setTitle("Find a game", for: .normal)
        view.addAction(UIAction { [weak self] _ in
             self?.presenter.didTapFindGame()
        }, for: .touchUpInside)
        return view
    }()

    private lazy var createTourneyButton: SketchButton = {
        let view = SketchButton()
        view.isSelected = true
        view.setTitle("Create a tourney", for: .normal)
        view.setImage(UIImage.Icon.createTourney, for: .normal)
        view.addAction(UIAction { [weak self] _ in
             self?.presenter.didTapCreateTourney()
        }, for: .touchUpInside)
        return view
    }()

    private lazy var donateButton: SketchButton = {
        let view = SketchButton()
        view.setTitle("Donate", for: .normal)
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
        print("🏀 displayCreateNewGameButton: \(state)")
    }

    // MARK: - Private Methods

    private func setupView() {
        view.addSubview(mainStackView)

        mainStackView.pinToSuperviewEdges(insets: Constants.contentInsets)
    }
}
