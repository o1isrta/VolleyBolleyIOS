//
//  FAQTableViewCell.swift
//  VolleyBolley
//
//  Created by Вадим on 02.09.2025.
//

import UIKit

final class FAQCell: UITableViewCell {

    static let faqId = "FAQCell"

    // MARK: - Private Properties

    private var separatorHeightConstraint: NSLayoutConstraint?

    private lazy var titleLabel = CustomTitle(
        text: String(localized: ""),
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
        backgroundColor = .clear
        selectionStyle = .none
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Method

    func configure(with item: FAQItem, isLast: Bool) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        separatorLine.isHidden = isLast
    }

        // MARK: - Private Method

        private func setupSeparatorLineHeight() {
            let separatorHeight = separatorLine.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
            separatorHeight.isActive = true
        }
}

// MARK: - Private methods

private extension FAQCell {

    func setupUI() {
        [stack, separatorLine].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func setupView() {
        setupUI()
        setupSeparatorLineHeight()

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
