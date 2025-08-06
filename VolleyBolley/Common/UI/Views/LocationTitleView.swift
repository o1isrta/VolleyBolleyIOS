//
//  LocationTitleView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 05.08.2025.
//

import UIKit

// MARK: - LocationTitleViewModel

struct LocationTitleViewModel {
	let title: String
	let location: String
}

/// Custom View to show information about court: title and location
final class LocationTitleView: UIView {

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

	func configure(with model: LocationTitleViewModel) {
		titleLabel.text = model.title
		locationLabel.text = model.location
	}
}

// MARK: - Private Methods

private extension LocationTitleView {

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
			titleStackView
		].forEach {
			mainStackView.addArrangedSubview($0)
		}

		addSubviews(mainStackView)

		NSLayoutConstraint.activate([
			iconImageView.heightAnchor.constraint(equalToConstant: 15),
			iconImageView.widthAnchor.constraint(equalToConstant: 15),

			mainStackView.heightAnchor.constraint(equalToConstant: 36),
			mainStackView.topAnchor.constraint(equalTo: topAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
}
