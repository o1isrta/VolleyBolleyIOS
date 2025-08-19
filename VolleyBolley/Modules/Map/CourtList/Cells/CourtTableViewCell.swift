//
//  CourtTableViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

final class CourtTableViewCell: UITableViewCell {

	static var reuseIdentifier: String = "CourtTableViewCell"

    // MARK: - Private Properties

    private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [locationTitleView, distanceView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()

	private lazy var locationTitleView = LocationTitleView(type: .none)
	private lazy var distanceView = DistanceView()

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

    func configure(with court: CourtModel, distance: Double) {
		let locationTitleViewModel = LocationTitleViewModel(
			title: court.location.courtName,
			location: court.location.locationName
		)
		locationTitleView.configure(with: locationTitleViewModel)

        let distanceText: String
        if distance >= 0 {
            distanceText = distance < 1
                ? String(format: "%.0f m", distance * 1000)
                : String(format: "%.1f km", distance)
        } else {
            distanceText = "—"
        }

		distanceView.configure(distance: distanceText)
    }
}

// MARK: - Private Methods

private extension CourtTableViewCell {

    func setupUI() {
        selectionStyle = .none
		backgroundColor = .clear

        contentView.addSubviews(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

			distanceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			distanceView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
