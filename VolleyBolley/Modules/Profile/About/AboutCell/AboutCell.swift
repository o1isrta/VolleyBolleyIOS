//
//  AboutCell.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import UIKit

// MARK: - Cell

final class AboutCell: UITableViewCell {

    // MARK: - Constants

    static let reuseIdentifier = "AboutCell"

    private enum Constants {
        static let horizontalInset: CGFloat = 20
        static let verticalInset: CGFloat = 12
        static let minHeight: CGFloat = 51
        static let titleWidth: CGFloat = 120
    }

    // MARK: - Private Properties

    private let titleLabel = CustomLabel(text: "", isBold: true)

    private let valueLabel: CustomLabel = {
        let label = CustomLabel(text: "", isBold: false)
        label.font = AppFont.Hero.regular(size: 16)
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 12
        stack.distribution = .fill
        return stack
    }()

    private var gradientLayer: CAGradientLayer?

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

    func configure(with item: AboutItem, isLast: Bool = false) {
        titleLabel.text = item.title
        valueLabel.text = item.value
        separatorLine.isHidden = isLast
        setNeedsLayout()
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer?.removeFromSuperlayer()
        guard let text = titleLabel.text, !text.isEmpty else { return }

        let gradient = CALayer.makeGradientTextMask(for: titleLabel)
        gradient.frame = titleLabel.bounds

        if let textLayer = gradient.mask as? CATextLayer {
            textLayer.alignmentMode = .left
        }

        titleLabel.layer.addSublayer(gradient)
        gradientLayer = gradient
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
