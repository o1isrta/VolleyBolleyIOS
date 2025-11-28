//
//  PlayersListViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 27.11.2025.
//

import UIKit

final class PlayersListViewController: BaseViewController {

	// MARK: - Private Properties

	// TODO: - remove it in the future
	private var playersMock: [String] = [
		"Polina Vasilieva",
		"Kristina Popova",
		"Anton Ivanov",
		"Aleksandr Abramov"
	]

	private enum LayoutConstants {
		static let mainIndent: CGFloat = 8
		static let mediumIndent: CGFloat = 16
		static let mainSpacing: CGFloat = 20

		static let initialTableHeight: CGFloat = 0
		static let backButtonSize: CGFloat = 24

		static let fontSize: CGFloat = 16
		static let screenTitleNumberOfLines: Int = 1
	}

	private lazy var screenTitle: CustomTitle = {
		let label = CustomTitle(
			text: String(localized: "playersList.title"),
			isLarge: true
		)
		label.numberOfLines = LayoutConstants.screenTitleNumberOfLines
		return label
	}()

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
//			self?.presenter?.backButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var searchBar = GradientSearchField(type: .search)
	private lazy var segmentedControl = CustomSegmentedControl(type: .players)

	private lazy var mainStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			searchBar,
			segmentedControl,
			tableView
		])
		stack.axis = .vertical
		stack.spacing = LayoutConstants.mediumIndent
		stack.alignment = .fill
		stack.distribution = .fill
		return stack
	}()

	private lazy var glassmorphismView = GlassmorphismView()

	private var tableViewHeightConstraint: NSLayoutConstraint?
	private var tableViewContentSizeObserver: NSKeyValueObservation?

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.register(PlayersListViewCell.self,
			forCellReuseIdentifier: PlayersListViewCell.reuseIdentifier)
		return tableView
	}()

	// MARK: - Initializers

//	init(presenter: ) {
//		self.presenter = presenter
//		super.init(nibName: nil, bundle: nil)
//	}
//
//	@available(*, unavailable)
//	required init?(coder: NSCoder) { nil }

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		hideKeyboardWhenTappedAround()
		setupTableViewContentSizeObserver()
	}
}

// MARK: - Private methods

private extension PlayersListViewController {

	func setupTableViewContentSizeObserver() {
		tableViewContentSizeObserver = tableView.observe(
			\.contentSize,
			 options: [.new]
		) { [weak self] _, change in
			guard
				let self,
				let newSize = change.newValue
			else { return }
			// Limiting the max height to preserve scrolling
			let maxHeight = UIScreen.main.bounds.height - 315
			let newHeight = min(newSize.height, maxHeight)
			self.tableViewHeightConstraint?.constant = newHeight
		}
	}

	func setupUI() {
		view.addSubviews(
			glassmorphismView,
			backButton,
			screenTitle,
			mainStack
		)
		setupConstraints()
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: LayoutConstants.mainIndent),
			glassmorphismView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: LayoutConstants.mainIndent),
			glassmorphismView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -LayoutConstants.mainIndent),
			glassmorphismView.bottomAnchor.constraint(
				equalTo: tableView.bottomAnchor,
				constant: LayoutConstants.mainIndent / 2),

			backButton.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: LayoutConstants.mainSpacing
			),
			backButton.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing
			),
			backButton.heightAnchor.constraint(equalToConstant: LayoutConstants.backButtonSize),
			backButton.widthAnchor.constraint(equalToConstant: LayoutConstants.backButtonSize),

			screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
			screenTitle.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
			screenTitle.leadingAnchor.constraint(
				greaterThanOrEqualTo: backButton.trailingAnchor,
				constant: LayoutConstants.mainIndent),
			screenTitle.trailingAnchor.constraint(
				lessThanOrEqualTo: glassmorphismView.trailingAnchor,
				constant: -LayoutConstants.mainSpacing),

			mainStack.topAnchor.constraint(
				equalTo: screenTitle.bottomAnchor,
				constant: LayoutConstants.mediumIndent
			),
			mainStack.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing
			),
			mainStack.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor,
				constant: -LayoutConstants.mainSpacing
			)
		])

		tableViewHeightConstraint = tableView.heightAnchor.constraint(
			equalToConstant: LayoutConstants.initialTableHeight
		)
		tableViewHeightConstraint?.isActive = true
	}
}

// MARK: - UITableViewDataSource

extension PlayersListViewController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		return playersMock.isEmpty ? 1 : playersMock.count// TODO: -
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: PlayersListViewCell.reuseIdentifier,
			for: indexPath) as? PlayersListViewCell else {
			return UITableViewCell()
		}
		if playersMock.isEmpty {// TODO: -
			cell.configureAsNoPlayers()
			return cell
		}
		// TODO: -
		let model = PlayerListCellViewModel(
			avatar: UIImage.imgPerson,
			name: playersMock[indexPath.row],
			isFavorite: false,
			level: PlayerLevel.pro.title
		) {
			print("change isFavorite")
		}
		cell.configure(with: model)
		return cell
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	PlayersListViewController()
}
#endif
