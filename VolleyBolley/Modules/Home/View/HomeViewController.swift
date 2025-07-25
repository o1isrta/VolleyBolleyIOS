//
//  HomeViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Combine
import UIKit

protocol HomeViewProtocol: AnyObject {
    func showGreeting(_ message: String)
    func displayNavBar(viewModel: NavBarViewModel)
    func displayError(message: String)
}

extension HomeViewController: CalendarComponentDelegate {
	func didSelectDate(_ date: Date) {
		updateDateLabel(with: date)
	}
}

final class HomeViewController: BaseViewController, HomeViewProtocol {

    // MARK: - Private Properties

	private lazy var calendarComponent: CalendarComponentProtocol = CalendarComponent(delegate: self)

    private let presenter: HomePresenterProtocol

    private lazy var navigationBarView = CustomNavBarView()

    private lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = AppFont.Quantex.regular(size: 16)
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
        label.text = message
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
        view.addSubview(label)
        setupLayout()
    }

    private func setupLayout() {
        setupConstraintsNavBar()
        setupConstraintsLabel()

		setupCalendar()
    }

    // MARK: - Constraints

    private func setupConstraintsNavBar() {
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 106)
        ])
    }

    private func setupConstraintsLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

	private func setupCalendar() {
		let calendarVC = calendarComponent.createCalendarViewController()
		addChild(calendarVC)
		view.addSubviews(calendarVC.view)
		calendarVC.didMove(toParent: self)

		NSLayoutConstraint.activate([
			calendarVC.view.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
			calendarVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			calendarVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			calendarVC.view.widthAnchor.constraint(equalToConstant: 319),
			calendarVC.view.heightAnchor.constraint(equalToConstant: 330)
		])
	}

	private func updateDateLabel(with date: Date) {
		let formatter = DateFormatter()
		formatter.dateStyle = .full
		formatter.timeStyle = .none
		label.text = "Выбранная дата: \(formatter.string(from: date))"
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
