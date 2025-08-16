//
//  CourtTableViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

class CourtTableViewCell: UITableViewCell {

    // MARK: - Private Properties

    private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [locationTitleView, distanceContainer])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()

	private lazy var locationTitleView = LocationTitleView(type: .none)

    private lazy var distanceContainer: UIView = {
        let view = UIView()
		view.backgroundColor = AppColor.Background.badgeDefault
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.primary
        label.textAlignment = .center
        return label
    }()

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

        distanceLabel.text = distanceText
    }
}

// MARK: - Private Methods

private extension CourtTableViewCell {

    func setupUI() {
        selectionStyle = .none
		backgroundColor = .clear

        distanceContainer.addSubviews(distanceLabel)
        contentView.addSubviews(mainStackView)

        NSLayoutConstraint.activate([
            // Main stack
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            // Distance container
            distanceContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            distanceContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            // Distance label
            distanceLabel.topAnchor.constraint(equalTo: distanceContainer.topAnchor, constant: 4),
            distanceLabel.leadingAnchor.constraint(equalTo: distanceContainer.leadingAnchor, constant: 8),
            distanceLabel.trailingAnchor.constraint(equalTo: distanceContainer.trailingAnchor, constant: -8),
            distanceLabel.bottomAnchor.constraint(equalTo: distanceContainer.bottomAnchor, constant: -4),
            distanceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
}
