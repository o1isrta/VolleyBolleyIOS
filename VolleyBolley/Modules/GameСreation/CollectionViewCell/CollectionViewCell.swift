//
//  CollectionViewCell.swift
//  VolleyBolley
//
//  Created by Вадим on 23.08.2025.
//

import UIKit

final class PlayerCell: UITableViewCell {
    
    static let playerCellidentifier = "PlayerCell"

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with name: String) {
        nameLabel.text = name
    }
}
