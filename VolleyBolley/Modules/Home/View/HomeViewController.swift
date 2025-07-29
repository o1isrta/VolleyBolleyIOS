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
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var hStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    private let hStackView = UIStackView()


    private let primaryButton = AppButtonPrimaryView(.nextStep)

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
//        label.text = message
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
        setupLayout()
    }

    private func setupLayout() {
        setupConstraintsNavBar()
        setupScrollView()
        setupVStackView()
        addPrimaryButtons()
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

    private func setupVStackView() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            vStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            vStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func addPrimaryButtons() {
        let primaryNormal = AppButtonPrimaryView(.done, initialState: .normal)
        let primarySelected = AppButtonPrimaryView(.done, initialState: .selected)
        let primaryDisabled = AppButtonPrimaryView(.done, initialState: .disabled)

//        let secondary = AppButtonSecondaryView(.selectDate)
//        let action = AppButtonActionView(.invitePlayers)
//        let icon = AppButtonIconView(.back)

        [primaryNormal, primarySelected, primaryDisabled].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            vStackView.addArrangedSubview($0)
        }
    }

    private func addSecondaryButtons() {
        let light = AppButtonSecondaryView(.levelLight, initialState: .selected)


        [light].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            hStackView.addArrangedSubview($0)
        }
    }

    //        let action = AppButtonActionView(.invitePlayers)
    //        let icon = AppButtonIconView(.back)
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
