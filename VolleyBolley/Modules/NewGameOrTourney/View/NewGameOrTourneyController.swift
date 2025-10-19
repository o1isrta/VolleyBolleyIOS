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

	private let glassmorphismView = GlassmorphismView()

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
		button.isEnabled = false
		return button
	}()

	// MARK: - Public Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		presenter?.viewDidLoad()
	}

	func setupTitle(with title: String) {
		titleLabel.text = title
	}
}

// MARK: - Private Methods

private extension NewGameOrTourneyViewController {

	func setupView() {
		view.addSubviews(
			glassmorphismView,
			backButton,
			titleLabel,
			tableView,
			nextButton
		)
		setupUI()
	}

	func setupUI() {
		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: Constants.padding
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
				equalTo: nextButton.topAnchor,
				constant: -Constants.paddingDouble
			),
			backButton.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: Constants.backButtonTopInset
			),
			backButton.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: Constants.backButtonTopInset
			),
			backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonSize),
			backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonSize),
			titleLabel.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

			tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Constants.tableTopInset),
			tableView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor),
			tableView.bottomAnchor.constraint(
				equalTo: glassmorphismView.bottomAnchor,
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

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		6
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		// cell with message
		switch indexPath.row {
		case 0:
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: NewGameOrTourneyMessageCell.reuseIdentifier,
				for: indexPath
			) as? NewGameOrTourneyMessageCell {
				cell.onMessageChange = { [weak self] text in
					print("Current message: \(text)")
				}
				return cell
			}
		case 1:
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: NewGameOrTourneyPlaceCell.reuseIdentifier,
				for: indexPath
			) as? NewGameOrTourneyPlaceCell {
				let shortCourt = LocationTitleViewModel(
					title: "Karon Beach Club",
					location: "Patak Rd, Mueang Phuket"
				)
				let callback = {
					print("Callback")
				}
				cell.configure(with: shortCourt, callback: callback)
				return cell
			}
		case 2:
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: NewGameOrTourneyDateCell.reuseIdentifier,
				for: indexPath
			) as? NewGameOrTourneyDateCell {
				let callback: (GameDateRange) -> Void = { date in
					print("Callback \(date)")
				}
				let reloadTable: () -> Void = { [weak self] in
					print("reloadTable")
					self?.tableView.reloadData()
				}
				cell.configure(callback: callback, reloadTable: reloadTable)
				return cell
			}
		case 3:
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: NewGameOrTourneyTypeCell.reuseIdentifier,
				for: indexPath
			) as? NewGameOrTourneyTypeCell {
				var tourneyType: GameTourneyType = .individual
				print("Tourney Type: \(tourneyType)")
				let callback: (GameTourneyType) -> Void = { newType in
					tourneyType = newType
					print("New tourney type: \(tourneyType)")
				}
				cell.configure(callback: callback)
				return cell
			}
		case 4:
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: NewGameOrTourneyGenderCell.reuseIdentifier,
				for: indexPath
			) as? NewGameOrTourneyGenderCell {
				var gender: GameGenderType = .mix
				print("Gender: \(gender)")
				let callback: (GameGenderType) -> Void = { newGender in
					gender = newGender
					print("New gender: \(gender)")
				}
				cell.configure(callback: callback)
				return cell
			}
		case 5:
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: NewGameOrTourneyPlayerLevelCell.reuseIdentifier,
				for: indexPath
			) as? NewGameOrTourneyPlayerLevelCell {
				let callback: ([PlayerLevel]) -> Void = { levels in
					print("New levels: \(levels)")
				}
				cell.configure(callback: callback)
				return cell
			}
		default:
			return UITableViewCell()
		}
		return UITableViewCell()
	}
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	NewGameOrTourneyViewController()
}
#endif
