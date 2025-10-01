//
//  FAQTableViewCell.swift
//  VolleyBolley
//
//  Created by Вадим on 02.09.2025.
//

import UIKit

struct FAQTableViewCellViewModel {
	let title: String
	let description: String
	let isLastItem: Bool

	init(faqItem: FAQItem, isLastItem: Bool) {
		self.title = faqItem.title
		self.description = faqItem.subtitle
		self.isLastItem = isLastItem
	}
}

final class FAQTableViewCell: UITableViewCell {

	static let faqId = "FAQTableViewCell"

	// MARK: - Private Properties

	private lazy var titleLabel = CustomTitle(
		text: "",
		isLarge: false
	)

	private lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColor.Text.primary
		label.font = AppFont.Hero.regular(size: 16)
		label.numberOfLines = 0
		return label
	}()

	private lazy var separatorLine = CustomSeparator()

	private lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
		stack.axis = .vertical
		stack.spacing = 16
		stack.alignment = .fill
		return stack
	}()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Method

	func configure(with model: FAQTableViewCellViewModel) {
		titleLabel.text = model.title
		subtitleLabel.text = model.description
		separatorLine.isHidden = model.isLastItem
	}
}

// MARK: - Private methods

private extension FAQTableViewCell {

	func setupView() {
		contentView.addSubviews(
			stack,
			separatorLine
		)
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
