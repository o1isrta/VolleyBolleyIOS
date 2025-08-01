//
//  CourtTitleView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import UIKit

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

	private lazy var shortDescriptionLabel: UILabel = {
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

	private lazy var nearestLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.backgroundColor = AppColor.Background.badgeDefault
		label.layer.cornerRadius = 10
		label.layer.masksToBounds = true
		label.textAlignment = .center
		label.sizeToFit()
		label.text = String(localized: "Nearest")
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

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func configure(with court: CourtModel, isNearest: Bool) {
		titleLabel.text = court.name
		shortDescriptionLabel.text = court.shortDescription
		nearestLabel.isHidden = !isNearest
	}
}
// MARK: - Private Methods

private extension CourtTitleView {

	func setupUI() {
		backgroundColor = .clear
		// court description
		[
			titleLabel,
			shortDescriptionLabel
		].forEach {
			titleStackView.addArrangedSubview($0)
		}
		// header
		[
			iconImageView,
			titleStackView,
			nearestLabel
		].forEach {
			mainStackView.addArrangedSubview($0)
		}

		addSubviews(mainStackView)

		NSLayoutConstraint.activate([
			iconImageView.heightAnchor.constraint(equalToConstant: 15),
			iconImageView.widthAnchor.constraint(equalToConstant: 15),

			nearestLabel.heightAnchor.constraint(equalToConstant: 23),
			nearestLabel.widthAnchor.constraint(equalToConstant: 81),
			nearestLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),

			mainStackView.heightAnchor.constraint(equalToConstant: 36),
			mainStackView.topAnchor.constraint(equalTo: topAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
	}
}
