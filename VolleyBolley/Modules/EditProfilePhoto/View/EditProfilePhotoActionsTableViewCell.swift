//
//  EditProfilePhotoActionsTableViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 05.11.2025.
//

import UIKit

final class EditProfilePhotoActionsTableViewCell: UITableViewCell {

	static let reuseIdentifier = "EditProfilePhotoActionsTableViewCell"

	func configure(model: PhotoAction) {
		var content = defaultContentConfiguration()
		let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
		backgroundColor = AppColor.Background.primary

		let selectedView = UIView()
		selectedView.backgroundColor = AppEffect.Table.cellWhiteSelected
		selectedBackgroundView = selectedView

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
