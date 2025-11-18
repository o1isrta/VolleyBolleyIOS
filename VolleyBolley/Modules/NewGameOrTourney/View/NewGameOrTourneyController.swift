//
//  NewGameOrTourneyController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

protocol NewGameOrTourneyViewControllerProtocol: AnyObject {
	var presenter: NewGameOrTourneyPresenterProtocol? { get set }
	func setupTitle(with title: String)
	func allowNextStep(_ allow: Bool)
	func showAlert(with message: String)
}

final class NewGameOrTourneyViewController: BaseViewController, NewGameOrTourneyViewControllerProtocol {

	// MARK: - Public Properties

	var presenter: NewGameOrTourneyPresenterProtocol?

	// MARK: - Private Properties

	private	enum Constants {
		static let padding: CGFloat = 8
		static let paddingDouble: CGFloat = 16

		static let tableTopInset: CGFloat = 4
		static let tableEstimatedRowHeight: CGFloat = 80

		static let backButtonTopInset: CGFloat = 20
		static let backButtonSize: CGFloat = 24

		static let bottomInset: CGFloat = 63

		static let titleFontSize: CGFloat = 24
	}

	private let glassView = GlassView()

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.title.game"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		return label
	}()

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
			self?.presenter?.backButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = Constants.tableEstimatedRowHeight
		tableView.register(
			NewGameOrTourneyMessageCell.self,
			forCellReuseIdentifier: NewGameOrTourneyMessageCell.reuseIdentifier)
		tableView.register(
			NewGameOrTourneyPlaceCell.self,
			forCellReuseIdentifier: NewGameOrTourneyPlaceCell.reuseIdentifier)
		tableView.register(
			NewGameOrTourneyDateCell.self,
			forCellReuseIdentifier: NewGameOrTourneyDateCell.reuseIdentifier)
		tableView.register(
			NewGameOrTourneyGenderCell.self,
			forCellReuseIdentifier: NewGameOrTourneyGenderCell.reuseIdentifier)
		tableView.register(
			NewGameOrTourneyPlayerLevelCell.self,
			forCellReuseIdentifier: NewGameOrTourneyPlayerLevelCell.reuseIdentifier)
		tableView.register(
			NewGameOrTourneyTypeCell.self,
			forCellReuseIdentifier: NewGameOrTourneyTypeCell.reuseIdentifier)
		return tableView
	}()

	private lazy var nextButton: YellowButton = {
		let button = YellowButton(title: String(localized: "button.next"))
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
		setupView()
		presenter?.viewDidLoad()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		view.bringSubviewToFront(customAlertView)
	}

	func setupTitle(with title: String) {
		titleLabel.text = title
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

private extension NewGameOrTourneyViewController {

	func setupView() {
		view.addSubviews(
            glassView,
			backButton,
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
            glassView.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: Constants.padding
			),
            glassView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Constants.padding
			),
            glassView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Constants.padding
			),
            glassView.bottomAnchor.constraint(
				equalTo: nextButton.topAnchor,
				constant: -Constants.paddingDouble
			),
			backButton.topAnchor.constraint(
				equalTo: glassView.topAnchor,
				constant: Constants.backButtonTopInset
			),
			backButton.leadingAnchor.constraint(
				equalTo: glassView.leadingAnchor,
				constant: Constants.backButtonTopInset
			),
			backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonSize),
			backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonSize),
			titleLabel.centerXAnchor.constraint(equalTo: glassView.centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

			tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Constants.tableTopInset),
			tableView.leadingAnchor.constraint(equalTo: glassView.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: glassView.trailingAnchor),
			tableView.bottomAnchor.constraint(
				equalTo: glassView.bottomAnchor,
				constant: -Constants.padding
			),

			nextButton.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Constants.padding
			),
			nextButton.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Constants.padding
			),
			nextButton.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: -Constants.bottomInset
			)
		])
	}
}

// MARK: - UITableViewDataSource

extension NewGameOrTourneyViewController: UITableViewDataSource {

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
		let gameType = presenter?.getCellType(index: indexPath.row)
		switch gameType {
		case .message:
			return makeMessageCell(for: indexPath)
		case .location:
			return makeLocationCell(for: indexPath)
		case .date:
			return makeDateCell(for: indexPath)
		case .tourneyType:
			return makeTourneyTypeCell(for: indexPath)
		case .gender:
			return makeGenderCell(for: indexPath)
		case .playerLevels:
			return makePlayerLevelsCell(for: indexPath)
		case .none:
			return UITableViewCell()
		}
	}

	func makeMessageCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: NewGameOrTourneyMessageCell.reuseIdentifier,
			for: indexPath
		) as? NewGameOrTourneyMessageCell else {
			return UITableViewCell()
		}

		cell.onMessageChange = { [weak self] message in
			self?.presenter?.setupMessage(message)
		}
		return cell
	}

	func makeLocationCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: NewGameOrTourneyPlaceCell.reuseIdentifier,
			for: indexPath
		) as? NewGameOrTourneyPlaceCell else {
			return UITableViewCell()
		}

		if let location = presenter?.location {
			cell.configure(with: location) { [weak self] in
				self?.presenter?.backButtonTapped()
			}
		}
		return cell
	}

	func makeDateCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: NewGameOrTourneyDateCell.reuseIdentifier,
			for: indexPath
		) as? NewGameOrTourneyDateCell else {
			return UITableViewCell()
		}

		let callback: (GameDateRange) -> Void = { [weak self] dateRange in
			self?.presenter?.setupDateRange(dateRange)
		}

		cell.configure(callback: callback) { [weak self] in
			self?.tableView.reloadData()
		}
		return cell
	}

	func makeTourneyTypeCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: NewGameOrTourneyTypeCell.reuseIdentifier,
			for: indexPath
		) as? NewGameOrTourneyTypeCell else {
			return UITableViewCell()
		}

		cell.configure { [weak self] tourneyType in
			self?.presenter?.setupTourneyType(to: tourneyType)
		}
		return cell
	}

	func makeGenderCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: NewGameOrTourneyGenderCell.reuseIdentifier,
			for: indexPath
		) as? NewGameOrTourneyGenderCell else {
			return UITableViewCell()
		}

		cell.configure { [weak self] gender in
			self?.presenter?.setupGender(to: gender)
		}
		return cell
	}

	func makePlayerLevelsCell(for indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: NewGameOrTourneyPlayerLevelCell.reuseIdentifier,
			for: indexPath
		) as? NewGameOrTourneyPlayerLevelCell else {
			return UITableViewCell()
		}

		cell.configure { [weak self] levels in
			self?.presenter?.setupPlayerLevels(to: levels)
		}
		return cell
	}
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	NewGameOrTourneyAssembly.createModule(with: nil)
}
#endif
