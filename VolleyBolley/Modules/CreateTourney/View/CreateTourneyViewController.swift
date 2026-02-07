//
//  CreateTourneyController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.02.2026.
//

import UIKit

protocol CreateTourneyViewProtocol: AnyObject {
	var presenter: CreateTourneyPresenterProtocol? { get set }

	func updateSaveButtonState(isEnabled: Bool)
	func updateAccountInfo(accountNumber: String)
}

final class CreateTourneyViewController: BaseViewController {

	// MARK: - Public Properties

	var presenter: CreateTourneyPresenterProtocol?

	// MARK: - Private Properties

	private	enum Constants {
		static let padding: CGFloat = 8
		static let mainSpacing: CGFloat = 20

		static let backButtonTopInset: CGFloat = 14
		static let saveTourneyButtonHeight: CGFloat = 44
	}

	private let glassView = GlassmorphismView()

	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsVerticalScrollIndicator = false
		return scrollView
	}()

	private let contentView = UIView()

	private let screenTitle = CustomTitle(
		text: String(localized: "createTourney.title"),
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

	private lazy var tourneyCounter: CounterWithTitleView = .init(type: .players) { [weak self] value in
		self?.presenter?.updatePlayersCount(to: value)
	}

	private let separator = CustomSeparator()

	private lazy var paymentView = PaymentView(
		priceChanged: { [weak self] price in
			self?.presenter?.priceChangedTo(value: price)
		},
		addPaymentButtonAction: { [weak self] in
			self?.presenter?.addPaymentButtonTapped()
		}
	)

	private lazy var saveTourneyButton: YellowButton = {
		let button = YellowButton()
		button.isEnabled = false
		button.isSelected = true
		button.setTitle(String(localized: "createTourney.saveTourneyButton"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.presenter?.saveTourneyButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var mainStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			tourneyCounter,
			separator,
			paymentView,
			saveTourneyButton
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
		hideKeyboardWhenTappedAround()
	}
}

// MARK: - Private Methods

private extension CreateTourneyViewController {

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
			saveTourneyButton.heightAnchor.constraint(equalToConstant: Constants.saveTourneyButtonHeight)
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
	}
}

// MARK: - CreateTourneyViewProtocol

extension CreateTourneyViewController: CreateTourneyViewProtocol {

	func updateSaveButtonState(isEnabled: Bool) {
		saveTourneyButton.isEnabled = isEnabled
	}

	func updateAccountInfo(accountNumber: String) {
		paymentView.setAccountNumber(to: accountNumber)
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	CreateTourneyAssembly.createModule()
}
#endif
