//
//  CourtImageView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 02.08.2025.
//

import UIKit

final class CourtImageView: UIView {

	// MARK: - Private Properties

	private lazy var courtImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 16
		imageView.backgroundColor = AppColor.Background.modal
		return imageView
	}()

	private lazy var tagStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 4
		stackView.alignment = .leading
		stackView.distribution = .equalSpacing
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

	func configure(with court: CourtModel) {
//		if let url = courtData.imageUrl {
//			// Здесь можно добавить асинхронную загрузку изображения
//			courtImageView.image = courtData.imageUrl
//		}
		courtImageView.image = UIImage(named: "court")

		tagStackView.arrangedSubviews.forEach {
			$0.removeFromSuperview()
		}
		court.tagList.forEach {
			let tagLabel = UILabel()
			tagLabel.font = AppFont.Hero.regular(size: 16)
			tagLabel.textColor = AppColor.Text.primary
			tagLabel.textAlignment = .center
			tagLabel.text = $0

			let container = UIView()
			container.backgroundColor = AppColor.Background.badgeSelected
			container.layer.cornerRadius = 6

			container.addSubviews(tagLabel)
			NSLayoutConstraint.activate([
				tagLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 2),
				tagLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4),
				tagLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4),
				tagLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -2)
			])
			tagStackView.addArrangedSubview(container)
		}
	}

	// MARK: - Private Methods

	private func setupUI() {
		addSubviews(
			courtImageView,
			tagStackView
		)

		courtImageView.addSubviews(tagStackView)

		NSLayoutConstraint.activate([
			courtImageView.topAnchor.constraint(equalTo: topAnchor),
			courtImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			courtImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			courtImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

			tagStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			tagStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			tagStackView.heightAnchor.constraint(equalToConstant: 23)
		])
	}
}
