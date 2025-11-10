//
//  UserCardController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 06.11.2025.
//

import UIKit

final class UserCardController: BaseViewController {

	// MARK: - Public Properties

//	var presenter: UserCardControllerPresenterProtocol?

	// MARK: - Private Properties

	private enum LayoutConstants {
		static let littleIndent: CGFloat = 4
		static let mainIndent: CGFloat = 8
		static let mediumIndent: CGFloat = 16
		static let mainSpacing: CGFloat = 20
		static let backButtonTopInset: CGFloat = 14
		static let mainStackTopInset: CGFloat = 59
		static let screenTitleLeftInset: CGFloat = 42

		static let profilePhotoSize: CGFloat = 100

		static let tableEstimatedRowHeight: CGFloat = 87
		static let initialTableHeight: CGFloat = 0
		static let favoriteButtonHeight: CGFloat = 44
		static let backButtonSize: CGFloat = 24

		static let fontSize: CGFloat = 16
	}

	private let loadingIndicator = ProgressHub.shared

	private lazy var glassmorphismView = GlassmorphismView()

	private lazy var screenTitle: CustomTitle = {
		let label = CustomTitle(text: "", isLarge: true)
		label.numberOfLines = 1
		return label
	}()

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
//			self?.presenter?.backButtonTapped()// TODO: -
		}, for: .touchUpInside)
		return button
	}()

	private lazy var profilePhotoView = AvatarImageView()

	private lazy var levelLabel: GradientLabel = {
		let label = GradientLabel()
		label.font = AppFont.Hero.bold(size: LayoutConstants.fontSize)
		label.textColor = AppColor.Text.primary
		label.text = "-"
		return label
	}()

	private lazy var tableCaptionLabel: CustomLabel = CustomLabel(
		text: String(localized: "userCard.tableCaption"),
		isBold: true
	)

	private var tableViewHeightConstraint: NSLayoutConstraint?
	private var tableViewContentSizeObserver: NSKeyValueObservation?

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = LayoutConstants.tableEstimatedRowHeight
		tableView.register(
			UserCardCell.self,
			forCellReuseIdentifier: UserCardCell.reuseIdentifier)
		return tableView
	}()

	private lazy var favoriteButton: YellowButton = {
		let button = YellowButton(
			title: String(localized: "button.favorite"),
			isSelected: true
		)
		button.isHidden = false
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.isFavoriteHidden(true)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var unfavoriteButton: YellowButton = {
		let button = YellowButton(
			title: String(localized: "button.unfavorite"),
			isSelected: false
		)
		button.isHidden = true
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.isFavoriteHidden(false)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var mainStack: UIStackView = {
		profilePhotoView.setContentHuggingPriority(.required, for: .horizontal)
		profilePhotoView.setContentHuggingPriority(.required, for: .vertical)
		profilePhotoView.setContentCompressionResistancePriority(.required, for: .horizontal)
		profilePhotoView.setContentCompressionResistancePriority(.required, for: .vertical)
		let stack = UIStackView(arrangedSubviews: [
			profilePhotoView,
			levelLabel,
			tableCaptionLabel,
			tableView,
			buttonsStack
		])
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = LayoutConstants.littleIndent
		return stack
	}()

	private lazy var buttonsStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			favoriteButton,
			unfavoriteButton
		])
		stack.axis = .vertical
		stack.alignment = .fill
		stack.spacing = LayoutConstants.littleIndent
		return stack
	}()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupTableViewContentSizeObserver()
	}

	func configure() {
		// TODO: -
		screenTitle.text = "Polina Vasilieva"
		profilePhotoView.configure(with: .imgPerson)
		levelLabel.text = "PRO"
	}
}

// MARK: - Private Methods

private extension UserCardController {

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
			let maxHeight = UIScreen.main.bounds.height - 489
			let newHeight = min(newSize.height, maxHeight)
			self.tableViewHeightConstraint?.constant = newHeight
		}
	}

	func isFavoriteHidden(_ favorite: Bool) {
		favoriteButton.isHidden = favorite
		unfavoriteButton.isHidden = !favorite
//		presenter?.setAsFavorite(favorite)// TODO: -
	}

	func setupView() {
		setupViews()
		setupLoadingIndicator()
	}

	func setupViews() {
		view.addSubviews(
			glassmorphismView,
			backButton,
			screenTitle,
			mainStack
		)
		setupConstraints()
	}

	func setupLoadingIndicator() {
		view.addSubviews(loadingIndicator)
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}

	func setupConstraints() {
		setupMainViewsConstraints()
		setupContentConstraints()
	}

	func setupMainViewsConstraints() {
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
				equalTo: buttonsStack.bottomAnchor,
				constant: LayoutConstants.mainSpacing),

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
				constant: -LayoutConstants.mainSpacing)
		])
	}

	func setupContentConstraints() {
		NSLayoutConstraint.activate([
			profilePhotoView.widthAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),
			profilePhotoView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),

			tableCaptionLabel.topAnchor.constraint(
				equalTo: levelLabel.bottomAnchor,
				constant: LayoutConstants.mainIndent),
			tableCaptionLabel.leadingAnchor.constraint(
				equalTo: mainStack.leadingAnchor),
			tableCaptionLabel.trailingAnchor.constraint(
				lessThanOrEqualTo: mainStack.trailingAnchor),

			tableView.topAnchor.constraint(
				equalTo: tableCaptionLabel.bottomAnchor,
				constant: LayoutConstants.mainIndent),
			tableView.leadingAnchor.constraint(
				equalTo: mainStack.leadingAnchor),
			tableView.trailingAnchor.constraint(
				lessThanOrEqualTo: mainStack.trailingAnchor),

			buttonsStack.topAnchor.constraint(
				equalTo: tableView.bottomAnchor,
				constant: LayoutConstants.mainSpacing),
			buttonsStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			buttonsStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
			buttonsStack.bottomAnchor.constraint(
				equalTo: mainStack.bottomAnchor,
				constant: LayoutConstants.mainSpacing),
			buttonsStack.heightAnchor.constraint(equalToConstant: LayoutConstants.favoriteButtonHeight),

			mainStack.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: LayoutConstants.mainStackTopInset),
			mainStack.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing),
			mainStack.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor,
				constant: -LayoutConstants.mainSpacing)
		])

		tableViewHeightConstraint = tableView.heightAnchor.constraint(
			equalToConstant: LayoutConstants.initialTableHeight
		)
		tableViewHeightConstraint?.isActive = true
	}
}

// MARK: - UITableViewDataSource

extension UserCardController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		3// TODO: -
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: UserCardCell.reuseIdentifier,
			for: indexPath
		) as? UserCardCell else {
			return UITableViewCell()
		}
		// TODO: -
//		let cellData = presenter?.getCellType(index: indexPath.row)
		let court = CourtModel.mockData
		let locationModel = LocationTitleViewModel(
			title: court.location.courtName,
			location: court.location.locationName
		)
		let model = UserCardCellViewModel(
			date: Date(),
			location: locationModel
		) {
			print("open map at location:", court.location.latitude, court.location.longitude)
		}

		cell.configure(with: model)

		return cell
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	let view = UserCardController()
	view.configure()
	return view
}

#endif
