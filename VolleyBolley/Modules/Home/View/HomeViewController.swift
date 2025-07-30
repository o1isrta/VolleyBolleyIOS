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

    private lazy var iconButtonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
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
        view.distribution = .fillEqually
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

    private lazy var actionButtonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
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

        vStackView.addArrangedSubview(iconButtonsStackView)
        vStackView.addArrangedSubview(primaryButtonsStackView)
        vStackView.addArrangedSubview(secondaryButtonsStackView)
        vStackView.addArrangedSubview(tertiaryButtonsStackView)
        vStackView.addArrangedSubview(actionButtonsStackView)

//        addIconButtons()
//        addPrimaryButtons()
        addSecondaryButtons()
//        addTertiaryButtons()
//        addActionButtons()

        setupLayout()
    }

    private func setupLayout() {
        setupConstraintsNavBar()
        setupScrollView()
        setupConstraintsVStackView()
    }

    // MARK: - Buttons

    private func addPrimaryButtons() {
        let primaryNormal = AppButtonPrimaryView(.done, initialState: .normal)
        let primarySelected = AppButtonPrimaryView(.done, initialState: .selected)
        let primaryDisabled = AppButtonPrimaryView(.done, initialState: .disabled)

        [primaryNormal, primarySelected, primaryDisabled].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            primaryButtonsStackView.addArrangedSubview($0)
        }
    }

    private func addSecondaryButtons() {
        let lightButton = AppButtonSecondaryView(.levelLight, initialState: .selected)
        let mediumButton = AppButtonSecondaryView(.levelMedium, initialState: .selected)
        let hardButton = AppButtonSecondaryView(.levelHard, initialState: .selected)
        let proButton = AppButtonSecondaryView(.levelPro)

        [lightButton, mediumButton, hardButton, proButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            secondaryButtonsStackView.addArrangedSubview($0)
        }
    }

    private func addTertiaryButtons() {
        let tertiaryButton = AppButtonTertiaryView(.map)

        tertiaryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tertiaryButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        tertiaryButtonsStackView.addArrangedSubview(tertiaryButton)
    }

    private func addActionButtons() {
        let tourneyButton = AppButtonActionView(.createTourney, initialState: .selected)
        let donateButton = AppButtonActionView(.donate)

        [tourneyButton, donateButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 180).isActive = true
            actionButtonsStackView.addArrangedSubview($0)
        }
    }

    private func addIconButtons() {
        let backButton = AppButtonIconView(.back)
        let minusButton = AppButtonIconView(.minus)
        let plusButton = AppButtonIconView(.plus)

        [backButton, minusButton, plusButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            iconButtonsStackView.addArrangedSubview($0)
        }
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
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
