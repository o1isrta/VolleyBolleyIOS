//
//  CreationSuccessInfoCell.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 11.09.2025.
//

import UIKit

enum CreationInfoType {
    case place
    case time
    case level
    case price

    var icon: UIImage {
        switch self {
        case .place:
            UIImage.Icon.location
        case .time:
            UIImage.Icon.group
        case .level:
            UIImage.Icon.volleyball
        case .price:
            UIImage.Icon.fluentPayment
        }
    }
}

struct CreationInfoItem {
    let type: CreationInfoType
    let title: String
    let description: String
}

final class CreationSuccessInfoCell: UITableViewCell {

    // MARK: - Constants

    private enum Constants {
        static let iconSize: CGFloat = 24
        static let spacing: CGFloat = 8
    }

    // MARK: - Static Properties

    static let reuseIdentifier = "CreationSuccessInfoCell"

    // MARK: - Private Properties

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Hero.bold(size: 16)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 1
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Hero.light(size: 14)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 1
        return label
    }()

    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .leading
        return stack
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Methods

    func configure(with item: CreationInfoItem) {
        iconImageView.image = item.type.icon
            .withRenderingMode(.alwaysOriginal)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubviews(iconImageView, labelStack)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),

            labelStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.spacing),
            labelStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            labelStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
