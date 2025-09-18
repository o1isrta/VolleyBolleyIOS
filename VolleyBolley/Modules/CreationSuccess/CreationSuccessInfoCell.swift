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

    private lazy var titleLabel: CustomLabel = {
        CustomLabel(text: "", isBold: true)
    }()

    private lazy var descriptionLabel: UILabel = {
        CustomLabel(text: "", isBold: false)
    }()

    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, labelStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.spacing
        return stack
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
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
        backgroundColor = AppColor.Background.clear
        contentView.backgroundColor = AppColor.Background.clear
        contentView.addSubviews(mainStack)

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
        ])
    }
}
