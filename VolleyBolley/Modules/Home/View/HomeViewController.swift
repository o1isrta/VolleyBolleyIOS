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

// TODO: - Delete demo buttons
final class HomeViewController: BaseViewController, HomeViewProtocol {

    // MARK: - Private Properties

    private let presenter: HomePresenterProtocol

    private lazy var navigationBarView: CustomNavBarView = {
        let view = CustomNavBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iconNormalButtonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iconSelectedButtonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var primaryButtonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var secondaryButtonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillProportionally
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tertiaryButtonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var actionButtonsFirstStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var actionButtonsSecondStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var actionButtonsThirdStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Primary buttons

    private lazy var primaryNormal: AppButtonPrimaryView = {
        let button = AppButtonPrimaryView(.done)
        button.setAction(self.didTapPrimaryButton)
        return button
    }()

    private lazy var primarySelected: AppButtonPrimaryView = {
        let button = AppButtonPrimaryView(.done)
        button.isSelected = true
        button.setAction(self.didTapPrimaryButton)
        return button
    }()

    private lazy var primaryDisabled: AppButtonPrimaryView = {
        let view = AppButtonPrimaryView(.done)
        view.isEnabled = false
        return view
    }()

    // MARK: - Secondary buttons

    private lazy var lightButton: AppButtonSecondaryView = {
        let view = AppButtonSecondaryView(.levelLight)
        view.isSelected = true
        view.setAction(self.didTapSecondaryButton)
        return view
    }()

    private lazy var mediumButton: AppButtonSecondaryView = {
        let view = AppButtonSecondaryView(.levelMedium)
        view.isSelected = true
        view.setAction(self.didTapSecondaryButton)
        return view
    }()

    private lazy var hardButton: AppButtonSecondaryView = {
        let view = AppButtonSecondaryView(.levelHard)
        view.isSelected = true
        view.setAction(self.didTapSecondaryButton)
        return view
    }()

    private lazy var proButton: AppButtonSecondaryView = {
        let view = AppButtonSecondaryView(.levelPro)
        view.isSelected = false
        view.setAction(self.didTapSecondaryButton)
        return view
    }()

    // MARK: - Tertiary buttons

    private lazy var tertiaryButton = AppButtonTertiaryView(.map)

    // MARK: - Action buttons

    private lazy var sendInvitesButton: AppButtonActionView = {
        let view = AppButtonActionView(.sendInvites)
        view.setAction(self.didTapActionButton)
        return view
    }()

    private lazy var saveGameButton: AppButtonActionView = {
        let view = AppButtonActionView(.saveGame)
        view.setAction(self.didTapActionButton)
        return view
    }()

    private lazy var invitePlayersButton: AppButtonActionView = {
        let view = AppButtonActionView(.invitePlayers)
        view.isSelected = true
        view.setAction(self.didTapActionButton)
        return view
    }()

    private lazy var shareLinkButton: AppButtonActionView = {
        let view = AppButtonActionView(.shareLink)
        view.setAction(self.didTapActionButton)
        return view
    }()

    private lazy var createTourneyButton: AppButtonActionView = {
        let view = AppButtonActionView(.createTourney)
        view.isSelected = true
        view.setAction(self.didTapActionButton)
        return view
    }()

    private lazy var donateButton: AppButtonActionView = {
        let view = AppButtonActionView(.donate)
        view.setAction(self.didTapActionButton)
        return view
    }()

    // MARK: - Icon buttons

    private lazy var backButtonNormal = AppButtonIconView(.backward)
    private lazy var minusButtonNormal = AppButtonIconView(.minus)
    private lazy var plusButtonNormal = AppButtonIconView(.plus)

    private lazy var backButtonSelected: AppButtonIconView = {
        let view = AppButtonIconView(.backward)
        view.isSelected = true
        return view
    }()

    private lazy var minusButtonSelected: AppButtonIconView = {
        let view = AppButtonIconView(.forward)
        view.isSelected = true
        return view
    }()

    private lazy var plusButtonSelected: AppButtonIconView = {
        let view = AppButtonIconView(.arrowUp)
        view.isSelected = true
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

    private func setupView() {
        view.addSubview(navigationBarView)
        view.addSubview(scrollView)

        scrollView.addSubview(vStackView)

        vStackView.addArrangedSubview(iconNormalButtonsStackView)
        vStackView.addArrangedSubview(iconSelectedButtonsStackView)
        vStackView.addArrangedSubview(primaryButtonsStackView)
        vStackView.addArrangedSubview(secondaryButtonsStackView)
        vStackView.addArrangedSubview(tertiaryButtonsStackView)
        vStackView.addArrangedSubview(actionButtonsFirstStackView)
        vStackView.addArrangedSubview(actionButtonsSecondStackView)
        vStackView.addArrangedSubview(actionButtonsThirdStackView)

        addIconNormalButtons()
        addIconSelectedButtons()
        addPrimaryButtons()
        addSecondaryButtons()
        addTertiaryButtons()
        addActionButtons()

        setupLayout()
    }

    private func setupLayout() {
        setupConstraintsNavBar()
        setupScrollView()
        setupConstraintsVStackView()
    }

    // MARK: - Buttons

    private func addPrimaryButtons() {
        [primaryNormal, primarySelected, primaryDisabled].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            primaryButtonsStackView.addArrangedSubview($0)
        }
    }

    private func addSecondaryButtons() {
        [lightButton, mediumButton, hardButton, proButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            secondaryButtonsStackView.addArrangedSubview($0)
        }
    }

    private func addTertiaryButtons() {
        tertiaryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tertiaryButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        tertiaryButtonsStackView.addArrangedSubview(tertiaryButton)
    }

    private func addActionButtons() {
        [sendInvitesButton, saveGameButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 180).isActive = true
            actionButtonsThirdStackView.addArrangedSubview($0)
        }

        [invitePlayersButton, shareLinkButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 180).isActive = true
            actionButtonsSecondStackView.addArrangedSubview($0)
        }

        [createTourneyButton, donateButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 180).isActive = true
            actionButtonsFirstStackView.addArrangedSubview($0)
        }
    }

    private func addIconNormalButtons() {
        [backButtonNormal, minusButtonNormal, plusButtonNormal].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            iconNormalButtonsStackView.addArrangedSubview($0)
        }
    }

    private func addIconSelectedButtons() {
        [backButtonSelected, minusButtonSelected, plusButtonSelected].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            iconSelectedButtonsStackView.addArrangedSubview($0)
        }
    }

    // MARK: - Actions

    private func didTapPrimaryButton(_ button: AppButtonPrimaryView) {
        button.isSelected.toggle()
        print("Primary button tapped. New state: isSelected = \(button.isSelected)")
    }

    private func didTapSecondaryButton(_ button: AppButtonSecondaryView) {
        button.isSelected.toggle()
        print("Secondary button tapped. New state: isSelected = \(button.isSelected)")
    }

    private func didTapActionButton(_ button: AppButtonActionView) {
        button.isSelected.toggle()
        print("Action button tapped. New state: isSelected = \(button.isSelected)")
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

    private func setupScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupConstraintsVStackView() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            vStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            vStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
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
