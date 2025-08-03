//
//  CourtTitleView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import UIKit

enum CourtTitleViewType: CaseIterable {
	case icon
	case none

	var isIconHidden: Bool {
		switch self {
		case .icon: return false
		case .none: return true
		}
	}
}

final class CourtTitleView: UIView {

	// MARK: - Private Properties

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.bold(size: 16)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 1
		label.textAlignment = .left
		return label
	}()

	private lazy var locationLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.light(size: 14)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 2
		label.textAlignment = .left
		return label
	}()

	private lazy var titleStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 0
		return stackView
	}()

	private lazy var iconImageView: UIImageView = {
		let image = UIImage(named: "location")
		let imageView = UIImageView(image: image)
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private lazy var distanceLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.backgroundColor = AppColor.Background.badgeDefault
		label.layer.cornerRadius = 10
		label.layer.masksToBounds = true
		label.textAlignment = .center
		label.sizeToFit()
		label.isHidden = true
		return label
	}()

	private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 10
		return stackView
	}()

	// MARK: - Initializers

	init(type: CourtTitleViewType) {
		super.init(frame: .zero)
		iconImageView.isHidden = type.isIconHidden
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func configure(with court: CourtModel, distance: String) {
		titleLabel.text = court.location.courtName
		locationLabel.text = court.location.locationName
		distanceLabel.text = distance
		distanceLabel.isHidden = distance.isEmpty
	}
}

// MARK: - Private Methods

private extension CourtTitleView {

	func setupUI() {
		backgroundColor = .clear
		// court description
		[
			titleLabel,
			locationLabel
		].forEach {
			titleStackView.addArrangedSubview($0)
		}
		// header
		[
			iconImageView,
			titleStackView,
			distanceLabel
		].forEach {
			mainStackView.addArrangedSubview($0)
		}

		addSubviews(mainStackView)

		NSLayoutConstraint.activate([
			iconImageView.heightAnchor.constraint(equalToConstant: 15),
			iconImageView.widthAnchor.constraint(equalToConstant: 15),

			distanceLabel.heightAnchor.constraint(equalToConstant: 23),
			distanceLabel.widthAnchor.constraint(equalToConstant: 81),
			distanceLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),

			mainStackView.heightAnchor.constraint(equalToConstant: 36),
			mainStackView.topAnchor.constraint(equalTo: topAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
}
