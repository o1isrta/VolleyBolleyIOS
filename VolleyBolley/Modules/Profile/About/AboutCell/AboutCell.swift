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
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = .clear
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: AboutItem) {
        titleLabel.text = item.title
        valueLabel.text = item.value
        setNeedsLayout()
    }

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

    private func setupView() {
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            titleLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
