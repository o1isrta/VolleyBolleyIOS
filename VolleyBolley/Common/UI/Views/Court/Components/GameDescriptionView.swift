//
//  GameDescriptionView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import UIKit

enum HostType: String, CaseIterable {
	case game
	case tournament

	var caption: String {
		switch self {
		case .game: return String(localized: "Game host")
		case .tournament: return String(localized: "Tournament host")
		}
	}
}

final class GameDescriptionView: UIView {

	// MARK: - Private Properties

	private lazy var captionLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.bold(size: 16)
		label.textColor = AppColor.Text.primary
		return label
	}()

	private lazy var userNameLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 1
		label.textAlignment = .left
		return label
	}()

	private lazy var userAvatarView = AvatarImageView()

	private lazy var userLevelLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.backgroundColor = AppColor.Background.badgeDefault
		label.layer.cornerRadius = 10
		label.layer.masksToBounds = true
		label.textAlignment = .center
		label.sizeToFit()
		return label
	}()

	private lazy var userStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 8
		return stackView
	}()

	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		return label
	}()

	private lazy var levelLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 1
		return label
	}()

	private lazy var genderLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		return label
	}()

	private lazy var descriptionStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 8
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

	func configure(with game: GameModel, hostType: HostType) {
		captionLabel.text = hostType.caption

		let time = Date.formatDateRange(startString: game.startTime, endString: game.endTime)
		dateLabel.setTextWithDifferentStyles([
			(String(localized: "When: "), AppFont.ActayWide.bold(size: 16)),
			(time ?? "-", AppFont.Hero.regular(size: 16))
		])

		levelLabel.setTextWithDifferentStyles([
			(String(localized: "Level: "), AppFont.ActayWide.bold(size: 16)),
			(game.levels.joined(separator: ", "), AppFont.Hero.regular(size: 16))
		])

		genderLabel.setTextWithDifferentStyles([
			(String(localized: "Gender: "), AppFont.ActayWide.bold(size: 16)),
			(game.gender, AppFont.Hero.regular(size: 16))
		])

		// TODO
		userAvatarView.configure(with: UIImage(named: "img-person"))
		userNameLabel.text = "\(game.host.firstName) \(game.host.lastName)"
		userLevelLabel.text = String(game.host.levelType.prefix(1).uppercased())
	}
}

// MARK: - Private Methods

private extension GameDescriptionView {

	func setupUI() {
		// user info
		[
			userAvatarView,
			userNameLabel,
			userLevelLabel
		].forEach {
			userStackView.addArrangedSubview($0)
		}
		// main stack
		[
			captionLabel,
			userStackView,
			dateLabel,
			levelLabel,
			genderLabel
		].forEach {
			descriptionStackView.addArrangedSubview($0)
		}

		addSubviews(descriptionStackView)

		NSLayoutConstraint.activate([
			userAvatarView.heightAnchor.constraint(equalToConstant: 40),
			userAvatarView.widthAnchor.constraint(equalToConstant: 40),

			userStackView.heightAnchor.constraint(equalToConstant: 40),
			userStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			userStackView.trailingAnchor.constraint(equalTo: trailingAnchor),

			userLevelLabel.heightAnchor.constraint(equalToConstant: 23),
			userLevelLabel.widthAnchor.constraint(equalToConstant: 30),
			userLevelLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

			descriptionStackView.topAnchor.constraint(equalTo: topAnchor),
			descriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			descriptionStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	ZStack {
		Color(cgColor: AppColor.Background.screen.cgColor)

		VStack {
			UIViewPreview {
				let view = GameDescriptionView()
				let game = GameModel.mockData
				view.configure(with: game, hostType: .game)
				return view
			}
			.frame(width: .infinity, height: 148)
			.padding()

			Divider()
				.background(Color(.systemGray5))

			UIViewPreview {
				let view = GameDescriptionView()
				let game = GameModel.mockData
				view.configure(with: game, hostType: .tournament)
				return view
			}
			.frame(width: .infinity, height: 148)
			.padding()
		}
	}
	.ignoresSafeArea()
}
#endif
