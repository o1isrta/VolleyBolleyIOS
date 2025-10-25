//
//  EditProfilePhotoActionsTableView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

final class EditProfilePhotoActionsTableView: UIView {

	// MARK: - Public Properties

	var didSelectAction: ((Int) -> Void)?

	// MARK: - Private Properties

	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.layer.cornerRadius = 32
		tableView.layer.masksToBounds = true
		tableView.isScrollEnabled = false
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
		tableView.separatorColor = AppColor.Border.separator
		tableView.register(
			EditProfilePhotoActionsTableViewCell.self,
			forCellReuseIdentifier: EditProfilePhotoActionsTableViewCell.reuseIdentifier
		)
		tableView.dataSource = self
		tableView.delegate = self
		return tableView
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) { nil }
}

// MARK: - Private Methods

private extension EditProfilePhotoActionsTableView {

	func setupView() {
		addSubviews(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

// MARK: - UITableViewDelegate

extension EditProfilePhotoActionsTableView: UITableViewDelegate {

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(
				withIdentifier: EditProfilePhotoActionsTableViewCell.reuseIdentifier,
				for: indexPath) as? EditProfilePhotoActionsTableViewCell,
			let action = PhotoAction(rawValue: indexPath.row)
		else {
			return UITableViewCell()
		}
		cell.configure(model: action)
		return cell
	}
}

// MARK: - UITableViewDataSource

extension EditProfilePhotoActionsTableView: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		return PhotoAction.allCases.count
	}

	func tableView(
		_ tableView: UITableView,
		heightForRowAt indexPath: IndexPath
	) -> CGFloat {
		return 58
	}

	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
		tableView.deselectRow(at: indexPath, animated: true)
		didSelectAction?(indexPath.row)
	}

	func tableView(
		_ tableView: UITableView,
		willDisplay cell: UITableViewCell,
		forRowAt indexPath: IndexPath
	) {
		let isLastCell = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1

		if isLastCell {
			cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
		}
	}
}

// MARK: - EditProfilePhotoActionsTableViewCell

final class EditProfilePhotoActionsTableViewCell: UITableViewCell {

	static let reuseIdentifier = "EditProfilePhotoActionsTableViewCell"

	func configure(model: PhotoAction) {
		var content = defaultContentConfiguration()
		let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
		content.image = UIImage(systemName: model.icon, withConfiguration: config)
		content.imageProperties.tintColor = AppColor.Text.inverted
		content.text = model.title
		content.textProperties.font = AppFont.Hero.regular(size: 16)
		content.textProperties.color = AppColor.Text.inverted
		contentConfiguration = content

		layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		preservesSuperviewLayoutMargins = false
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	EditProfilePhotoViewController()
}
#endif
