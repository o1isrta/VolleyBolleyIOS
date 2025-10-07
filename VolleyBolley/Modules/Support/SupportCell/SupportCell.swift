//
//  SupportCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

import UIKit

// MARK: - Cell

final class SupportCell: UITableViewCell {

    // MARK: - Constants

    static let reuseIdentifier = "SupportCell"

    private enum Constants {
        static let horizontalInset: CGFloat = 20
        static let verticalInset: CGFloat = 12
        static let minHeight: CGFloat = 51
        static let titleWidth: CGFloat = 100

        static let fontSize: CGFloat = 16
        static let textSpacing: CGFloat = 12
    }

    // MARK: - Private Properties

	private let titleLabel: GradientLabel = {
		let label = GradientLabel()
		label.font = AppFont.Hero.bold(size: Constants.fontSize)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 0
		return label
	}()

    private let valueLabel: CustomLabel = {
        let label = CustomLabel(text: "", isBold: false)
        label.font = AppFont.Hero.regular(size: Constants.fontSize)
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = Constants.textSpacing
        stack.distribution = .fill
        return stack
    }()

    private lazy var separatorLine = CustomSeparator()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = AppColor.Background.clear
        selectionStyle = .none
        setupView()
    }

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

    // MARK: - Configure

    func configure(with item: SupportItem, isLast: Bool = false) {
        titleLabel.text = item.title
        valueLabel.text = item.value
        separatorLine.isHidden = isLast
    }

    // MARK: - Private Methods

    private func setupView() {
        contentView.addSubviews(
			stack,
			separatorLine
		)
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: Constants.verticalInset
			),
			stack.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.horizontalInset
			),
			stack.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.horizontalInset
			),

			separatorLine.topAnchor.constraint(
				equalTo: stack.bottomAnchor,
				constant: Constants.verticalInset
			),
			separatorLine.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.horizontalInset
			),
			separatorLine.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.horizontalInset
			),
			separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			titleLabel.widthAnchor.constraint(equalToConstant: Constants.titleWidth),
			contentView.heightAnchor.constraint(
				greaterThanOrEqualToConstant: Constants.minHeight
			)
		])
    }
}
