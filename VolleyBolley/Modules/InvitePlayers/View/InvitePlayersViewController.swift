//
//  InvitePlayersViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import UIKit

protocol InvitePlayersViewControllerProtocol: AnyObject {
	func reloadData()
	func isLoadingIndicatorVisible(_ isLoading: Bool)
	func showAlert(with message: String)
}

final class InvitePlayersViewController: BaseViewController {

	// MARK: - Private Properties

	private let presenter: InvitePlayersPresenterProtocol
	private let playersListType: InvitePlayersListType

	private let loadingIndicator = ProgressHub.shared

	private enum LayoutConstants {
		static let mainIndent: CGFloat = 8
		static let mediumIndent: CGFloat = 16
		static let mainSpacing: CGFloat = 20
		static let actionButtonHeight: CGFloat = 44

		static let initialTableHeight: CGFloat = 0
		static let minCompensationTableHeight: CGFloat = 429
		static let maxTableHeight: CGFloat = 408
		static let rowTableHeight: CGFloat = 45
		static let footerTableHeight: CGFloat = 25
		static let initialFooterTableHeight: CGFloat = 0
		static let footerTableInset: CGFloat = 12

		static let backButtonSize: CGFloat = 24

		static let fontSize: CGFloat = 16
		static let screenTitleNumberOfLines: Int = 1
	}

	private lazy var screenTitle: CustomTitle = {
		let label = CustomTitle(text: playersListType.title, isLarge: true)
		label.numberOfLines = LayoutConstants.screenTitleNumberOfLines
		return label
	}()

	private lazy var caption: UIView = {
		let container = UIView()
		let label = CustomTitle(text: String(localized: "invitePlayers.caption"))
		container.addSubviews(label)
		label.pinToSuperviewEdges(insets: .init(
			top: LayoutConstants.mainIndent,
			left: .zero, bottom: .zero, right: .zero
		))
		container.isHidden = true
		return container
	}()

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
			self?.presenter.backButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var searchBar = GradientSearchField(type: .search)
	private lazy var segmentedControl = CustomSegmentedControl(type: .players)

	private lazy var mainStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			searchBar,
			segmentedControl,
			caption,
			tableView,
			actionButton
		])
		stack.axis = .vertical
		stack.spacing = LayoutConstants.mainIndent
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
		tableView.delegate = self
		tableView.rowHeight = LayoutConstants.rowTableHeight
		tableView.register(InvitePlayersViewCell.self,
			forCellReuseIdentifier: InvitePlayersViewCell.reuseIdentifier)
		return tableView
	}()

	private lazy var actionButton: YellowButton = {
		let button = YellowButton(title: playersListType.actionButtonTitle)
		button.isSelected = true
		button.isEnabled = true
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			switch playersListType {
			case .privateGame:
				self.presenter.didTapAddButton()
			case .regular:
				self.presenter.didTapInviteButton()
			}
		}, for: .touchUpInside)
		return button
	}()

	private lazy var alertView: CustomAlertView = CustomAlertView()

	// MARK: - Initializers

	init(
		presenter: InvitePlayersPresenterProtocol,
		playersListType: InvitePlayersListType
	) {
		self.presenter = presenter
		self.playersListType = playersListType
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		hideKeyboardWhenTappedAround()
		setupTableViewContentSizeObserver()
		presenter.viewDidLoad()
		setupActions()
		setupSearchTextField()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		view.bringSubviewToFront(loadingIndicator)
		view.bringSubviewToFront(alertView)
	}
}

// MARK: - InvitePlayersViewController

extension InvitePlayersViewController: InvitePlayersViewControllerProtocol {

	func reloadData() {
		tableView.reloadData()
	}

	func isLoadingIndicatorVisible(_ isLoading: Bool) {
		DispatchQueue.main.async {
			isLoading
			? self.loadingIndicator.show(in: self.view, withBlur: true, ballSize: .big)
			: self.loadingIndicator.hide()
			self.view.isUserInteractionEnabled = !isLoading
		}
	}

	func showAlert(with message: String) {
		alertView.isHidden = false
		let model = CustomAlertModel(
			message: message,
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.done"),
				action: { self.alertView.isHidden = true }
			)
		)
		alertView.configure(with: model)
	}
}

// MARK: - Private methods

private extension InvitePlayersViewController {

	func setupSearchTextField() {
		searchBar.addTarget(
			self,
			action: #selector(searchTextChanged),
			for: .editingChanged
		)
	}

	@objc func searchTextChanged() {
		filterPlayersList()
	}

	func setupActions() {
		segmentedControl.segmentChanged = { [weak self] index in
			guard
				let self,
				let playersListType = PlayersListType(rawValue: index)
			else { return }
			self.presenter.setPlayersList(playersListType)
			self.filterPlayersList()
		}
	}

	func filterPlayersList() {
		let playersListType = PlayersListType(rawValue: segmentedControl.selectedSegmentIndex)
		guard playersListType != nil else { return }

		let filterText = searchBar.text ?? ""
		presenter.filterPlayers(by: filterText)
		reloadData()
	}

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
			let compensation: CGFloat = caption.isHidden
			? LayoutConstants.minCompensationTableHeight
			: (
				LayoutConstants.minCompensationTableHeight
				+ LayoutConstants.mainIndent / 2
				+ caption.frame.height
				+ LayoutConstants.footerTableHeight
			)
			let maxHeight = max(
				UIScreen.main.bounds.height - compensation,
				LayoutConstants.maxTableHeight
			)
			let newHeight = min(newSize.height, maxHeight)
			self.tableViewHeightConstraint?.constant = newHeight
		}
	}

	func setupUI() {
		view.addSubviews(
			glassmorphismView,
			backButton,
			screenTitle,
			mainStack,
			alertView
		)
		setupConstraints()
	}

	func setupConstraints() {
		alertView.pinToSuperviewEdges()

		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: LayoutConstants.mainIndent),
			glassmorphismView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: LayoutConstants.mainIndent),
			glassmorphismView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -LayoutConstants.mainIndent),
			glassmorphismView.bottomAnchor.constraint(
				equalTo: actionButton.bottomAnchor,
				constant: LayoutConstants.mediumIndent),

			backButton.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: LayoutConstants.mainSpacing),
			backButton.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing),
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

			actionButton.heightAnchor.constraint(
				equalToConstant: LayoutConstants.actionButtonHeight),

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

extension InvitePlayersViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		presenter.numberOfSections()
	}

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		let playersCount = presenter.getPlayersCount(in: section)
		caption.isHidden = playersCount == 0 && section == InvitePlayerType.invited.rawValue
		return playersCount == 0 && section == InvitePlayerType.regular.rawValue ? 1 : playersCount
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: InvitePlayersViewCell.reuseIdentifier,
			for: indexPath) as? InvitePlayersViewCell
		else {
			return UITableViewCell()
		}
		if indexPath.section == InvitePlayerType.regular.rawValue,
		   presenter.getPlayersCount(in: indexPath.section) == 0 {
			cell.configureAsNoPlayers()
			return cell
		}
		let playerModel = presenter.getPlayer(at: indexPath)
		cell.configure(with: playerModel)
		return cell
	}
}

// MARK: - UITableViewDataSource

extension InvitePlayersViewController: UITableViewDelegate {

	func tableView(
		_ tableView: UITableView,
		heightForFooterInSection section: Int
	) -> CGFloat {
		let playersCount = presenter.getPlayersCount(in: section)
		return section == InvitePlayerType.invited.rawValue && playersCount > 0
		? LayoutConstants.footerTableHeight
		: LayoutConstants.initialFooterTableHeight
	}

	func tableView(
		_ tableView: UITableView,
		viewForFooterInSection section: Int
	) -> UIView? {
		guard section != InvitePlayerType.regular.rawValue else { return nil }

		let container = UIView()
		let separator = CustomSeparator()
		container.addSubviews(separator)
		separator.pinToSuperviewEdges(insets: .init(
			top: LayoutConstants.footerTableInset,
			left: .zero,
			bottom: LayoutConstants.footerTableInset,
			right: .zero
		))
		let playersCount = presenter.getPlayersCount(in: section)
		container.isHidden = playersCount == 0 && section == InvitePlayerType.invited.rawValue

		return container
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	let presenter = InvitePlayersPresenter(
		interactor: InvitePlayersInteractor(),
		router: InvitePlayersRouter()
	)
	InvitePlayersViewController(presenter: presenter, playersListType: .regular)
}
#endif
