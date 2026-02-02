//
//  CreateGameController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 22.08.2025.
//

import UIKit

protocol CreateGameViewProtocol: AnyObject {
	var presenter: CreateGamePresenterProtocol? { get set }

	func isPlayersListHidden(_ isHidden: Bool)
	func reloadPlayersTableData()
	func updateSaveButtonState(isEnabled: Bool)
	func updateAccountInfo(accountNumber: String)
}

final class CreateGameViewController: BaseViewController {

	// MARK: - Public Properties

	var presenter: CreateGamePresenterProtocol?

	// MARK: - Private Properties

	private	enum Constants {
		static let padding: CGFloat = 8
		static let mainSpacing: CGFloat = 20

		static let backButtonTopInset: CGFloat = 14
		static let saveGameButtonHeight: CGFloat = 44

		static let playersTableEstimatedRowHeight: CGFloat = 44
		static let playersTableInitialHeight: CGFloat = 0
		static let playersTableCellUIEdgeInset: UIEdgeInsets = .init(
			top: 0,
			left: 0,
			bottom: 24,
			right: 0
		)
	}

	private let glassView = GlassmorphismView()

	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsVerticalScrollIndicator = false
		return scrollView
	}()

	private let contentView = UIView()

	private let screenTitle = CustomTitle(
		text: String(localized: "createGame.title"),
		isLarge: true
	)

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
			self?.presenter?.backButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var playersCounter: CounterWithTitleView = .init(type: .players) { [weak self] value in
		self?.presenter?.updatePlayersCount(to: value)
	}

	private lazy var privacyView = GamePrivacyView { [weak self] isPublic in
		self?.presenter?.updateGamePrivacyState(isPublic: isPublic)
	}

	private var playersTableViewHeightConstraint: NSLayoutConstraint?
	private var playersTableViewContentSizeObserver: NSKeyValueObservation?
	private lazy var playersTableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = false
		tableView.dataSource = self
		tableView.estimatedRowHeight = Constants.playersTableEstimatedRowHeight
		tableView.register(PlayerElementListViewCell.self,
			forCellReuseIdentifier: PlayerElementListViewCell.reuseIdentifier)
		return tableView
	}()

	private lazy var managePlayersButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "createGame.managePlayersButton"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.presenter?.managePlayersButtonTapped()
		}, for: .touchUpInside)
		button.setContentCompressionResistancePriority(.required, for: .vertical)
		button.setContentHuggingPriority(.required, for: .vertical)
		return button
	}()
	private lazy var playersTableStackView: UIStackView = {
		let view = UIView()
		view.addSubviews(managePlayersButton)
		NSLayoutConstraint.activate([
			managePlayersButton.leftAnchor.constraint(equalTo: view.leftAnchor),
			managePlayersButton.topAnchor.constraint(equalTo: view.topAnchor),
			managePlayersButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		let stack = UIStackView(arrangedSubviews: [
			playersTableView,
			view
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .fill
		stack.isHidden = true
		return stack
	}()

	private let separator = CustomSeparator()

	private lazy var paymentView = PaymentView(
		priceChanged: { [weak self] price in
			// TODO: -
			print(price)
			self?.presenter?.priceChangedTo(value: price)
		},
		addPaymentButtonAction: { [weak self] in
			// TODO: -
			print("addPaymentButtonTapped")
			self?.presenter?.addPaymentButtonTapped()
		}
	)

	private lazy var saveGameButton: YellowButton = {
		let button = YellowButton()
		button.isEnabled = false
		button.isSelected = true
		button.setTitle(String(localized: "createGame.saveGameButton"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.presenter?.saveGameButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var mainStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			playersCounter,
			privacyView,
			playersTableStackView,
			separator,
			paymentView,
			saveGameButton
		])
		stack.axis = .vertical
		stack.alignment = .fill
		stack.spacing = Constants.mainSpacing
		return stack
	}()

	// MARK: - Public Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		presenter?.viewDidLoad()
		setupPlayersTableViewSizing()
		hideKeyboardWhenTappedAround()
	}
}

// MARK: - Private Methods

private extension CreateGameViewController {

	func setupUI() {
		view.addSubviews(glassView)
		glassView.addSubviews(
			screenTitle,
			backButton,
			scrollView
		)
		scrollView.addSubviews(contentView)
		contentView.addSubviews(mainStackView)

		setupConstraints()
		setupSubViewConstraints()
	}

	func setupSubViewConstraints() {
		NSLayoutConstraint.activate([
			saveGameButton.heightAnchor.constraint(equalToConstant: Constants.saveGameButtonHeight)
		])
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			backButton.topAnchor.constraint(equalTo: glassView.topAnchor, constant: Constants.backButtonTopInset),
			backButton.leadingAnchor.constraint(equalTo: glassView.leadingAnchor, constant: Constants.mainSpacing / 2),

			screenTitle.centerXAnchor.constraint(equalTo: glassView.centerXAnchor),
			screenTitle.topAnchor.constraint(equalTo: glassView.topAnchor, constant: Constants.mainSpacing),

			glassView.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: Constants.padding),
			glassView.leadingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.leadingAnchor,
				constant: Constants.padding),
			glassView.trailingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.trailingAnchor,
				constant: -Constants.padding),

			scrollView.topAnchor.constraint(
				equalTo: screenTitle.bottomAnchor,
				constant: Constants.mainSpacing),
			scrollView.leadingAnchor.constraint(
				equalTo: glassView.leadingAnchor,
				constant: Constants.mainSpacing),
			scrollView.trailingAnchor.constraint(
				equalTo: glassView.trailingAnchor,
				constant: -Constants.mainSpacing),
			scrollView.bottomAnchor.constraint(
				equalTo: glassView.bottomAnchor,
				constant: -Constants.mainSpacing),

			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

			mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])

		let scrollViewHeight = scrollView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
		scrollViewHeight.priority = .defaultLow
		scrollViewHeight.isActive = true

		let bottomToSafeArea = glassView.bottomAnchor.constraint(
			lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
			constant: -Constants.padding
		)
		bottomToSafeArea.priority = .required
		bottomToSafeArea.isActive = true

		// Table view inside stack view needs an explicit height
		playersTableViewHeightConstraint = playersTableView.heightAnchor.constraint(
			equalToConstant: Constants.playersTableInitialHeight
		)
		playersTableViewHeightConstraint?.isActive = true
	}

	func setupPlayersTableViewSizing() {
		playersTableViewContentSizeObserver = playersTableView.observe(
			\.contentSize,
			options: [.new]
		) { [weak self] _, change in
			guard
				let self,
				let newSize = change.newValue
			else { return }
			self.playersTableViewHeightConstraint?.constant = max(Constants.playersTableInitialHeight, newSize.height)
		}
	}
}

// MARK: - PaywallViewProtocol

extension CreateGameViewController: CreateGameViewProtocol {

	func isPlayersListHidden(_ isHidden: Bool) {
		playersTableStackView.isHidden = isHidden
	}

	func reloadPlayersTableData() {
		playersTableView.reloadData()
	}

	func updateSaveButtonState(isEnabled: Bool) {
		saveGameButton.isEnabled = isEnabled
	}

	func updateAccountInfo(accountNumber: String) {
		paymentView.setAccountNumber(to: accountNumber)
	}
}

// MARK: - UITableViewDataSource

extension CreateGameViewController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		return presenter?.getPlayersCount() ?? 0
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: PlayerElementListViewCell.reuseIdentifier,
			for: indexPath) as? PlayerElementListViewCell
		else {
			return UITableViewCell()
		}
		var state: PlayerElementRowState = .plainFreeSpot

		if let playerModel = presenter?.getPlayerBy(index: indexPath.item) {
			state = .plainWithAction(
				player: playerModel,
				deleteAction: { [weak self] in
					guard let self else { return }
					let index = indexPath.item
					self.presenter?.removePlayerBy(index: index)
				})
		}

		cell.configure(
			state: state,
			uiEdgeInsets: Constants.playersTableCellUIEdgeInset
		)

		return cell
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	CreateGameAssembly.createModule(invitePlayersFactory: { _, _  in nil })
}
#endif
