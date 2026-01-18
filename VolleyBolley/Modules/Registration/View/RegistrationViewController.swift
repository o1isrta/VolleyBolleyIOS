//
//  RegistrationViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import UIKit

// MARK: - RegistrationViewControllerProtocol

protocol RegistrationViewControllerProtocol: AnyObject {
	var presenter: RegistrationPresenterProtocol? { get set }
//	func updateCountries(_ countries: [String])
	func allowNextStep(_ allow: Bool)
	func showAlert(with message: String)
}

// MARK: - RegistrationViewController

final class RegistrationViewController: UIViewController, RegistrationViewControllerProtocol {

	// MARK: - Public Properties

	var presenter: RegistrationPresenterProtocol?

	// MARK: - Private Properties

	private enum Constants {
		static let padding: CGFloat = 8
		static let paddingDouble: CGFloat = 16

		static let mainInset: CGFloat = 20

		static let tableEstimatedRowHeight: CGFloat = 80
	}

	private let glassmorphismView = GlassmorphismView()

	private let titleLabel = CustomTitle(text: String(localized: "Registration"), isLarge: true)

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = Constants.tableEstimatedRowHeight
		tableView.register(
			RegistrationPlayerNameCell.self,
			forCellReuseIdentifier: RegistrationPlayerNameCell.reuseIdentifier)
		tableView.register(
			RegistrationPlayerGenderCell.self,
			forCellReuseIdentifier: RegistrationPlayerGenderCell.reuseIdentifier)
		tableView.register(
			RegistrationPlayerBirthdayCell.self,
			forCellReuseIdentifier: RegistrationPlayerBirthdayCell.reuseIdentifier)
		tableView.register(
			RegistrationPlayerLevelCell.self,
			forCellReuseIdentifier: RegistrationPlayerLevelCell.reuseIdentifier)
		tableView.register(
			RegistrationPlayerLocationCell.self,
			forCellReuseIdentifier: RegistrationPlayerLocationCell.reuseIdentifier)
		return tableView
	}()

	private lazy var nextButton: YellowButton = {
		let button = YellowButton(title: String(localized: "button.getStarted"))
		button.isSelected = true
		button.isEnabled = false
		button.addAction(UIAction { [weak self] _ in
			self?.presenter?.nextButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var customAlertView: CustomAlertView = CustomAlertView()

	// MARK: - Public Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = AppColor.Background.screen
		presenter?.viewDidLoad()
		setupView()
		hideKeyboardWhenTappedAround()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		view.bringSubviewToFront(customAlertView)
	}

	func allowNextStep(_ allow: Bool) {
		nextButton.isEnabled = allow
	}

	func showAlert(with message: String) {
		customAlertView.isHidden = false
		let model = CustomAlertModel(
			message: message,
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.ok"),
				action: { self.customAlertView.isHidden = true }
			)
		)
		customAlertView.configure(with: model)
	}
}

// MARK: - Private Methods

private extension RegistrationViewController {

	func setupView() {
		view.addSubviews(
			glassmorphismView,
			titleLabel,
			tableView,
			nextButton,
			customAlertView
		)
		setupUI()
	}

	func setupUI() {
		customAlertView.pinToSuperviewEdges()

		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor
			),
			glassmorphismView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Constants.padding
			),
			glassmorphismView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Constants.padding
			),
			glassmorphismView.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: Constants.padding
			),

			titleLabel.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: Constants.mainInset),
			titleLabel.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: Constants.mainInset
			),
			titleLabel.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor,
				constant: -Constants.mainInset
			),

			tableView.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: Constants.paddingDouble),
			tableView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor),
			tableView.bottomAnchor.constraint(
				equalTo: nextButton.topAnchor,
				constant: -Constants.paddingDouble
			),

			nextButton.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: Constants.mainInset
			),
			nextButton.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor,
				constant: -Constants.mainInset
			),
			nextButton.bottomAnchor.constraint(
				equalTo: glassmorphismView.bottomAnchor,
				constant: -Constants.mainInset
			)
		])
	}
}

// MARK: - UITableViewDataSource

extension RegistrationViewController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		presenter?.getICellsCount() ?? 0
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		let cellType = presenter?.getCellType(index: indexPath.row)
		switch cellType {
		case .name:
			return makeNameCell(type: .name, for: indexPath)
		case .surname:
			return makeNameCell(type: .surname, for: indexPath)
		case .birthday:
			return makeBirthdayCell(for: indexPath)
		case .gender:
			return makeGenderCell(for: indexPath)
		case .playerLevel:
			return makePlayerLevelsCell(for: indexPath)
		case .country:
			return makeLocationCell(type: .country, for: indexPath)
		case .city:
			return makeLocationCell(type: .city, for: indexPath)
		case .none:
			return UITableViewCell()
		}
	}

	func makeNameCell(
		type: RegistrationNameCellType,
		for indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: RegistrationPlayerNameCell.reuseIdentifier,
			for: indexPath
		) as? RegistrationPlayerNameCell else {
			return UITableViewCell()
		}
		cell.configure(type: type) { [weak self] value in
			switch type {
			case .name:
				self?.presenter?.setupName(to: value)
			case .surname:
				self?.presenter?.setupSurname(to: value)
			}
		}
		return cell
	}

	func makeLocationCell(
		type: RegistrationLocationType,
		for indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: RegistrationPlayerLocationCell.reuseIdentifier,
			for: indexPath
		) as? RegistrationPlayerLocationCell else {
			return UITableViewCell()
		}
		let items = presenter?.getLocation(type: type) ?? []
		cell.configure(type: type, items: items) { [weak self] value in
			self?.presenter?.setupLocation(type: type, to: value)
		}
		// TODO: -
//		cell.invalidateIntrinsicContentSize()
		return cell
	}

	func makeBirthdayCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: RegistrationPlayerBirthdayCell.reuseIdentifier,
			for: indexPath
		) as? RegistrationPlayerBirthdayCell else {
			return UITableViewCell()
		}
		cell.configure { [weak self] date in
			self?.presenter?.setupBirthday(to: date)
		}
		return cell
	}

	func makeGenderCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: RegistrationPlayerGenderCell.reuseIdentifier,
			for: indexPath
		) as? RegistrationPlayerGenderCell else {
			return UITableViewCell()
		}
		cell.configure { [weak self] gender in
			self?.presenter?.setupGender(to: gender)
		}
		return cell
	}

	func makePlayerLevelsCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: RegistrationPlayerLevelCell.reuseIdentifier,
			for: indexPath
		) as? RegistrationPlayerLevelCell else {
			return UITableViewCell()
		}
		let levelAction: () -> Void = { [weak self] in
			self?.presenter?.didTapLevelInfo()
		}
		cell.configure(levelAction: levelAction) { [weak self] level in
			self?.presenter?.setupPlayerLevel(to: level)
		}
		return cell
	}
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	RegistrationAssembly.createModule(with: nil)
}
#endif
