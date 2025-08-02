//
//  CourtDetailsCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.07.2025.
//

import UIKit

class CourtDetailsCell: UITableViewCell {

    // MARK: - Private Properties

	private let courtView = CourtView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    // MARK: - Public Methods

    func configure(with court: CourtModel) {
		courtView.configure(with: court)
    }
}

// MARK: - Private Methods

private extension CourtDetailsCell {

    func setupUI() {
        selectionStyle = .none
        contentView.addSubviews(courtView)
        NSLayoutConstraint.activate([
			courtView.topAnchor.constraint(equalTo: contentView.topAnchor),
			courtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			courtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			courtView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
