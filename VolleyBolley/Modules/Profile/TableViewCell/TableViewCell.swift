//
//  TableViewCell.swift
//  VolleyBolley
//
//  Created by Вадим on 05.08.2025.
//

import UIKit

final class MenuCell: UITableViewCell {

    static let identifier = "MenuCell"

    // MARK: - Private Properties

    private var separatorHeightConstraint: NSLayoutConstraint?

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 16)
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()

    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Border.separator
        return view
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

    func configure(iconName: String, title: String, isLast: Bool) {
        iconView.image = UIImage(named: iconName)
        titleLabel.text = title
        separatorLine.isHidden = isLast
    }

    // MARK: - Private Method

    private func setupSeparatorLineHeight() {
        let separatorHeightConstraint = separatorLine.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        separatorHeightConstraint.isActive = true
    }
}

// MARK: - Constants

extension MenuCell {

    func setupUI() {
        [stack, separatorLine].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupView() {
        setupUI()
        setupSeparatorLineHeight()

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),

            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
