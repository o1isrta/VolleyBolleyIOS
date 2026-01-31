//
//  PaywallController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 22.08.2025.
//

import UIKit

protocol PaywallViewProtocol: AnyObject {
	var presenter: PaywallPresenterProtocol? { get set }

	func updateSaveButtonState(isEnabled: Bool)
	func updatePaymentSelection(isSelected: Bool)
	func updatePrivacyState(isPublic: Bool)
	func updateAccountInfo(accountNumber: String)
	func updatePaymentDescription(text: String)
}

final class PaywallViewController: BaseViewController {

	// MARK: - Public Properties

	var presenter: PaywallPresenterProtocol?

	// MARK: - Private Properties

	private	enum Constants {
		static let padding: CGFloat = 8

		static let backButtonTopInset: CGFloat = 14

		static let priceViewHeight: CGFloat = 30
		static let priceViewWidth: CGFloat = 75

		static let saveGameButtonHeight: CGFloat = 44

		static let amountStackHeight: CGFloat = 52

		static let mainSpacing: CGFloat = 20
		static let stackInternalSpacing: CGFloat = 12
		static let stackLayoutMargins: UIEdgeInsets =  .init(
			top: Constants.stackInternalSpacing,
			left: 0,
			bottom: 0,
			right: 0
		)
		static let paymentStackSpacing: CGFloat = 9
		static let privacyButtonsStackSpacing: CGFloat = 10

		static let playersTableEstimatedRowHeight: CGFloat = 44
		static let playersTableInitialHeight: CGFloat = 0
		static let playersTableCellUIEdgeInset: UIEdgeInsets = .init(
			top: 0,
			left: 0,
			bottom: 24,
			right: 0
		)

		static let fontSize: CGFloat = 16
	}

	private let glassmorphismView = GlassmorphismView()

	private let screenTitle = CustomTitle(text: String(localized: "paywall.screenTitle"), isLarge: true)
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
		// TODO: -
		print(value)
	}

	private let privacyTitle = CustomTitle(text: String(localized: "paywall.privacyTitle"), isLarge: true)
	private let privacyDescription = CustomLabel(text: String(localized: "paywall.privacyDescription"))

	private lazy var privacyPublicButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "paywall.publicButton"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.presenter?.privacyPublicButtonTapped()
		}, for: .touchUpInside)
		return button
	}()
	private lazy var privacyPrivateButton: GreenButton = {
		let button = GreenButton(imagePlacement: .trailing)
		button.setTitle(String(localized: "paywall.privateButton"), for: .normal)
		button.setImage(.arrowForward, for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.presenter?.privacyPrivateButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var privacyButtonsStackView: UIStackView = {
		let view = UIView()
		view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		let stack = UIStackView(arrangedSubviews: [
			privacyPublicButton,
			privacyPrivateButton,
			view
		])
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .leading
		stack.spacing = Constants.privacyButtonsStackSpacing
		stack.layoutMargins = Constants.stackLayoutMargins
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

	private lazy var privacyStackView: UIStackView = {
		privacyTitle.setContentCompressionResistancePriority(.required, for: .vertical)
		privacyTitle.setContentHuggingPriority(.required, for: .vertical)
		privacyDescription.setContentCompressionResistancePriority(.required, for: .vertical)
		privacyDescription.setContentHuggingPriority(.required, for: .vertical)
		let stack = UIStackView(arrangedSubviews: [
			privacyTitle,
			privacyDescription,
			privacyButtonsStackView
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .fill
		return stack
	}()

	private let separator = CustomSeparator()

	private let paymentTitle = CustomTitle(text: String(localized: "paywall.paymentTitle"), isLarge: true)
	private let paymentDescription = CustomLabel(text: String(localized: "paywall.paymentDescription"))
	private let paymentPerPerson = CustomLabel(text: String(localized: "paywall.paymentPerPerson"), isBold: true)
	private lazy var priceView: PriceView = {
		let priceView = PriceView()
		priceView.text = "5"
		priceView.isUserInteractionEnabled = false
		priceView.onTextChanged = { [weak self] text in
			self?.presenter?.priceTextChanged(text: text)
		}
		return priceView
	}()
	private lazy var paymentPerPersonStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			paymentPerPerson,
			priceView
		])
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .center
		stack.spacing = Constants.paymentStackSpacing
		stack.layoutMargins = Constants.stackLayoutMargins
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

	private let currentAccountLabel: UILabel = {
		let label = UILabel()
		label.text = String(localized: "paywall.currentAccountLabel")
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		label.textColor = AppColor.Text.primary
		return label
	}()
	private lazy var accountLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		label.textColor = AppColor.Text.primary
		label.isHidden = true
		return label
	}()
	private lazy var addPaymentButton: GreenButton = {
		let button = GreenButton()
		button.isSelected = false
		button.setTitle(String(localized: "paywall.addPaymentButton"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.presenter?.addPaymentButtonTapped()
		}, for: .touchUpInside)
		return button
	}()
	private lazy var amountStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			currentAccountLabel,
			accountLabel,
			addPaymentButton
		])
		stack.axis = .horizontal
		stack.distribution = .equalSpacing
		stack.alignment = .center
		stack.layoutMargins = Constants.stackLayoutMargins
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

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

	private var playersTableViewHeightConstraint: NSLayoutConstraint?
	private var playersTableViewContentSizeObserver: NSKeyValueObservation?
	private lazy var managePlayersButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "paywall.managePlayersButton"), for: .normal)
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
		return stack
	}()

	private lazy var paymentStackView: UIStackView = {
		paymentTitle.setContentCompressionResistancePriority(.required, for: .vertical)
		paymentTitle.setContentHuggingPriority(.required, for: .vertical)
		paymentDescription.setContentCompressionResistancePriority(.required, for: .vertical)
		paymentDescription.setContentHuggingPriority(.required, for: .vertical)
		let stack = UIStackView(arrangedSubviews: [
			paymentTitle,
			paymentDescription,
			paymentPerPersonStackView,
			amountStackView
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .leading
		return stack
	}()

	private lazy var saveGameButton: YellowButton = {
		let button = YellowButton()
		button.isEnabled = false
		button.isSelected = true
		button.setTitle(String(localized: "paywall.saveGameButton"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.presenter?.updatePlayersCount(to: self.playersCounter.value)
			self.presenter?.saveGameButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsVerticalScrollIndicator = false
		return scrollView
	}()
	private let contentView = UIView()

	private lazy var mainStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			playersCounter,
			privacyStackView,
			playersTableStackView,
			separator,
			paymentStackView,
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

private extension PaywallViewController {

	func setupUI() {
		screenTitle.setContentCompressionResistancePriority(.required, for: .vertical)
		screenTitle.setContentHuggingPriority(.required, for: .vertical)

		view.addSubviews(glassmorphismView)
		glassmorphismView.addSubviews(
			screenTitle,
			backButton,
			scrollView
		)
		scrollView.addSubviews(contentView)
		contentView.addSubviews(mainStackView)

		NSLayoutConstraint.activate([
			backButton.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: Constants.backButtonTopInset),
			backButton.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: Constants.mainSpacing / 2),

			screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
			screenTitle.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: Constants.mainSpacing),

			amountStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
			amountStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
			amountStackView.heightAnchor.constraint(equalToConstant: Constants.amountStackHeight),

			priceView.heightAnchor.constraint(equalToConstant: Constants.priceViewHeight),
			priceView.widthAnchor.constraint(equalToConstant: Constants.priceViewWidth),

			saveGameButton.heightAnchor.constraint(equalToConstant: Constants.saveGameButtonHeight),

			glassmorphismView.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: Constants.padding
			),
			glassmorphismView.leadingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.leadingAnchor,
				constant: Constants.padding
			),
			glassmorphismView.trailingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.trailingAnchor,
				constant: -Constants.padding
			),

			scrollView.topAnchor.constraint(
				equalTo: screenTitle.bottomAnchor,
				constant: Constants.mainSpacing
			),
			scrollView.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: Constants.mainSpacing
			),
			scrollView.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor,
				constant: -Constants.mainSpacing
			),
			scrollView.bottomAnchor.constraint(
				equalTo: glassmorphismView.bottomAnchor,
				constant: -Constants.mainSpacing
			),

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
		// glassmorphismView.bottom = min(safeArea.bottom - padding, saveGameButton.bottom + mainSpacing)
		let bottomToContent = glassmorphismView.bottomAnchor.constraint(
			greaterThanOrEqualTo: saveGameButton.bottomAnchor,
			constant: Constants.mainSpacing
		)
		bottomToContent.priority = .defaultHigh
		bottomToContent.isActive = true

		let bottomToSafeArea = glassmorphismView.bottomAnchor.constraint(
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

extension PaywallViewController: PaywallViewProtocol {

	func updateSaveButtonState(isEnabled: Bool) {
		saveGameButton.isEnabled = isEnabled
	}

	func updatePaymentSelection(isSelected: Bool) {
		addPaymentButton.isHidden = isSelected
		accountLabel.isHidden = !isSelected
		priceView.isUserInteractionEnabled = isSelected
		priceView.becomeActive()
	}

	func updatePrivacyState(isPublic: Bool) {
		privacyPublicButton.isSelected = isPublic
		privacyPrivateButton.isSelected = !isPublic
	}

	func updateAccountInfo(accountNumber: String) {
		accountLabel.text = accountNumber
	}

	func updatePaymentDescription(text: String) {
		paymentDescription.text = text
	}
}

// MARK: - UITableViewDataSource

extension PaywallViewController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		// TODO: -
		return 7
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
		// TODO: -
		let player = PlayerElementListViewCellModel(
			firstName: Player.mockDefault.firstName,
			lastName: Player.mockDefault.lastName,
			level: Player.mockDefault.level.title,
			index: nil
		)
		cell.configure(
			state: .plainWithAction(
				player: player,
				deleteAction: { [weak self] in
					guard let self = self else { return }
					// TODO: -
					print("remove:", indexPath.item)
		//			self.playersMock.remove(at: indexPath.item)
//					self.playersTableView.deleteSections([indexPath.item], with: .automatic)
			}),
			uiEdgeInsets: Constants.playersTableCellUIEdgeInset
		)
		return cell
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	PaywallAssembly.createModule(with: nil)
}
#endif

