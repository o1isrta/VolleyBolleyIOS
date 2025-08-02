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

	private lazy var tagLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 14)
		label.textColor = AppColor.Text.primary
		label.backgroundColor = AppColor.Background.badgeSelected
		label.layer.cornerRadius = 6
		label.layer.masksToBounds = true
		label.textAlignment = .center
		label.sizeToFit()
		label.isHidden = true
		return label
	}()

	private lazy var tagStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 4
		stackView.alignment = .leading
//		stackView.distribution = .fillEqually
//		stackView.alignment = .center
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

		print(court)
		tagLabel.text = ""

		court.tagList.forEach {
			let tag = tagLabel
			tag.text = $0
			print($0)
			tagStackView.addArrangedSubview(tag)
		}
	}

	// MARK: - Private Methods

	private func setupUI() {
		addSubviews(
			courtImageView
//			tagStackView
		)

		courtImageView.addSubviews(tagStackView)

		NSLayoutConstraint.activate([
			courtImageView.topAnchor.constraint(equalTo: topAnchor),
			courtImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			courtImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			courtImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

			tagStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			tagStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			tagStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			tagStackView.heightAnchor.constraint(equalToConstant: 23)
		])
	}
}
