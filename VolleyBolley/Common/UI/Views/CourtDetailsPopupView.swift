//
//  CourtDetailsPopupView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

class CourtDetailsPopupView: UIView {

    // MARK: - Private Properties

	private lazy var courtTitleView: CourtTitleView = CourtTitleView(type: .icon)

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16// TODO
        imageView.backgroundColor = .systemGray5// TODO
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)// TODO
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)// TODO
        label.textColor = .systemBlue// TODO
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)// TODO
        label.numberOfLines = 0
        return label
    }()

    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)// TODO
        label.textColor = .systemGray// TODO
        return label
    }()

    private lazy var chooseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose this court", for: .normal)
        button.backgroundColor = .systemBlue// TODO
        button.setTitleColor(.white, for: .normal)// TODO
        button.layer.cornerRadius = 12// TODO
        return button
    }()

    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Public Methods

	func configure(with court: CourtModel, distance: String) {
		courtTitleView.configure(with: court, distance: distance)
		nameLabel.text = court.location.courtName
        priceLabel.text = court.price
		locationLabel.text = court.location.locationName
		phoneLabel.text = court.contacts?[0].value
        if let url = court.imageUrl {
            // Здесь можно добавить асинхронную загрузку изображения
            imageView.backgroundColor = .systemGray4
        } else {
            imageView.backgroundColor = .systemGray4
        }
    }
}

private extension CourtDetailsPopupView {

    private func setupUI() {
        backgroundColor = .systemGray2// TODO
        layer.cornerRadius = 24
        layer.masksToBounds = true

        [
            imageView,
            nameLabel,
            priceLabel,
            priceLabel,
			locationLabel,
            phoneLabel,
            chooseButton
        ].forEach {
            mainStack.addArrangedSubview($0)
        }

        addSubviews(
			courtTitleView,
			mainStack
		)

        NSLayoutConstraint.activate([
			courtTitleView.heightAnchor.constraint(equalToConstant: 36),
			courtTitleView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			courtTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			courtTitleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

			imageView.topAnchor.constraint(equalTo: courtTitleView.bottomAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            chooseButton.heightAnchor.constraint(equalToConstant: 44),

            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
