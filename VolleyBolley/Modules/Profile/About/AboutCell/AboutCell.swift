//
//  AboutCell.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import UIKit

// MARK: - Cell

final class AboutCell: UITableViewCell {

    static let reuseIdentifier = "AboutCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Hero.bold(size: 16)
        label.textColor = AppColor.Background.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 12
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var gradientLayer: CAGradientLayer?

    private lazy var separatorLine: UIView = {
        let view = CustomSeparator()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = AppColor.Background.clear
        selectionStyle = .none
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    // MARK: - Private

    private func setupSeparatorLineHeight() {
        let height = separatorLine.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        height.isActive = true
    }

    private func setupView() {
        contentView.addSubview(stack)
        contentView.addSubview(separatorLine)

        setupSeparatorLineHeight()

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            separatorLine.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 12),
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        titleLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
}
