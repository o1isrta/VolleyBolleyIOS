//
//  СhoiceTableViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 27.11.2025.
//

import UIKit

struct PlayerListCellViewModel {
	let avatar: UIImage
    let name: String
    let isFavorite: Bool
	let level: String
	let onFavoriteToggle: (() -> Void)?

	init(
		avatar: UIImage,
		name: String,
		isFavorite: Bool,
		level: String,
		onFavoriteToggle: (() -> Void)?
	) {
		self.avatar = avatar
		self.name = name
		self.isFavorite = isFavorite
		self.level = String(level.prefix(1).uppercased())
		self.onFavoriteToggle = onFavoriteToggle
	}
}

final class PlayersListViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let reuseIdentifier = "PlayersListViewCell"

	private enum Constants {
		static let stackSpacing: CGFloat = 8
		static let inset: CGFloat = -16

		static let avatarSize: CGFloat = 40
		static let badgeWidth: CGFloat = 30
		static let badgeHeight: CGFloat = 23

		static let fontSize: CGFloat = 16
	}

    // MARK: - Private Properties

    private var isFavorite: Bool = false
	private var onFavoriteToggle: (() -> Void)?

    private lazy var starButton: UIButton = {
        let button = UIButton()
		button.setImage(UIImage.Icon.noStar, for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didTapStar()
		}, for: .touchUpInside)
        return button
    }()

	private lazy var avatarImageView = AvatarImageView()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
        return label
    }()

    private lazy var leftStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			avatarImageView,
			nameLabel
		])
        stack.axis = .horizontal
        stack.alignment = .center
		stack.spacing = Constants.stackSpacing
        return stack
    }()

    private lazy var badgeView = BadgeView()

    private lazy var rightStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			starButton,
			badgeView
		])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.stackSpacing
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
			leftStack,
			rightStack
		])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
		stack.spacing = Constants.stackSpacing
        return stack
    }()

	private lazy var noPlayersLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.text = String(localized: "playersList.noPlayers")
		label.isHidden = true
		return label
	}()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = AppColor.Background.clear
        selectionStyle = .none
		setupUI()
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Public Method

    func configure(with model: PlayerListCellViewModel) {
		noPlayersLabel.isHidden = true
		mainStack.isHidden = false
		avatarImageView.image = model.avatar
        nameLabel.text = model.name
        isFavorite = model.isFavorite
		badgeView.configure(distance: model.level)
		onFavoriteToggle = model.onFavoriteToggle
        updateUI()
    }

	func configureAsNoPlayers() {
		noPlayersLabel.isHidden = false
		mainStack.isHidden = true
	}
}

// MARK: - Private methods

private extension PlayersListViewCell {

	func didTapStar() {
		isFavorite.toggle()
		updateUI()
		onFavoriteToggle?()
	}

	func updateUI() {
		starButton.setImage(isFavorite
			? UIImage.Icon.star
			: UIImage.Icon.noStar,
		for: .normal)
	}

    func setupUI() {
		contentView.addSubviews(mainStack, noPlayersLabel)
        setupConstraints()
    }

    func setupConstraints() {
        leftStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        rightStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate([
			avatarImageView.widthAnchor.constraint(
				equalToConstant: Constants.avatarSize),
			avatarImageView.heightAnchor.constraint(
				equalToConstant: Constants.avatarSize),

			noPlayersLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.inset),
			noPlayersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			noPlayersLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			badgeView.widthAnchor.constraint(equalToConstant: Constants.badgeWidth),
			badgeView.heightAnchor.constraint(equalToConstant: Constants.badgeHeight),

			mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
			mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.inset)
        ])
    }
}

// MARK: - Preview

#if DEBUG

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	ZStack {
		Color(AppColor.Background.badgeSelected)
			.ignoresSafeArea()

		VStack {
			UIViewPreview {
				let view = PlayersListViewCell()
				view.configureAsNoPlayers()
				return view
			}
			.background(Color(uiColor: AppColor.Background.screen))
			.frame(width: 319, height: 40)

			UIViewPreview {
				let view = PlayersListViewCell()
				let model = PlayerListCellViewModel(
					avatar: UIImage.imgPerson,
					name: Player.mockDefault.firstName + " " + Player.mockDefault.lastName,
					isFavorite: false,
					level: PlayerLevel.pro.title
				) {
					print("change isFavorite")
				}
				view.configure(with: model)
				return view
			}
			.background(Color(uiColor: AppColor.Background.screen))
			.frame(width: 319, height: 52)
		}
	}
}
#endif
