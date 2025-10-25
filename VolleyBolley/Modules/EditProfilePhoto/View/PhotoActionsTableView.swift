//
//  PhotoActionsTableView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

private enum PhotoActionsConstants {
    static let actions: [(icon: String, title: String)] = [
        ("photo", String(localized: "Choose from Gallery")),
        ("camera", String(localized: "Take photo")),
        ("trash", String(localized: "Delete photo"))
    ]
}

final class PhotoActionsTableView: UIView {

    var didSelectAction: ((Int) -> Void)?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.layer.cornerRadius = 32
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
		tableView.separatorColor = AppColor.Border.separator
		tableView.register(ActionsTableViewCell.self,
			forCellReuseIdentifier: ActionsTableViewCell.reuseIdentifier
		)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { nil }
}

// MARK: - Private Methods

private extension PhotoActionsTableView {

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

extension PhotoActionsTableView: UITableViewDelegate {

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: ActionsTableViewCell.reuseIdentifier,
			for: indexPath) as? ActionsTableViewCell else {
			return UITableViewCell()
		}
		let action = PhotoActionsConstants.actions[indexPath.row]
		cell.configure(iconName: action.0, title: action.1)
		return cell
	}
}

// MARK: - UITableViewDataSource

extension PhotoActionsTableView: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
        return PhotoActionsConstants.actions.count
    }

	func tableView(
		_ tableView: UITableView,
		heightForRowAt indexPath: IndexPath
	) -> CGFloat {
        return 56
    }

	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle selection
        didSelectAction?(indexPath.row)
    }

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let isLastCell = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1

		if isLastCell {
			cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
		}
	}
}

// MARK: - ActionsTableViewCell

final class ActionsTableViewCell: UITableViewCell {

	static let reuseIdentifier = "ActionsTableViewCell"

    func configure(iconName: String, title: String) {
        var content = defaultContentConfiguration()
		let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        content.image = UIImage(systemName: iconName, withConfiguration: config)
        content.imageProperties.tintColor = AppColor.Text.inverted
        content.text = title
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
