//
//  CourtDetailsCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.07.2025.
//

import UIKit

class CourtDetailsCell: UITableViewCell {

    // MARK: - Private Properties

	private let detailsView = CourtView()

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
		detailsView.configure(with: court)
    }
}

// MARK: - Private Methods

private extension CourtDetailsCell {

    func setupUI() {
        selectionStyle = .none
        contentView.addSubviews(detailsView)
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
