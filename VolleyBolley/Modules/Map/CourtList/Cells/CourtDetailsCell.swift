//
//  CourtDetailsCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.07.2025.
//

import UIKit

final class CourtDetailsCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "CourtDetailsCell"

	// MARK: - Private Properties

	private let courtAndGameView = CourtAndGameView()
	private lazy var separator = CustomSeparator()

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

	func configure(with court: CourtModel, isLast: Bool) {
		let model = CourtViewModel(
			court: court,
			doneButtonData: ButtonDataModel(
				title: "CHOOSE THIS COURT",
				// TODO: - тут будет переход на создание экрана игры/турнира
				/// guard let selectedCourt else { return }
				/// presenter.didTapSelectCourtButton(create: .tourney, selectedCourt: selectedCourt)
				action: { print("CHOOSE THIS COURT: click clack") }
			)
		)
		courtAndGameView.configure(with: model)
		separator.isHidden = isLast
	}
}

// MARK: - Private Methods

private extension CourtDetailsCell {

	func setupUI() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.addSubviews(courtAndGameView, separator)
		NSLayoutConstraint.activate([
			courtAndGameView.topAnchor.constraint(equalTo: contentView.topAnchor),
			courtAndGameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			courtAndGameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			courtAndGameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

			separator.heightAnchor.constraint(equalToConstant: 1),
			separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1)
		])
	}
}
