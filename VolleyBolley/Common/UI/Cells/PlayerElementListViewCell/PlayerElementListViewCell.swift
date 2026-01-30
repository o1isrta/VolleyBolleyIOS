//
//  PlayerElementListViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.01.2026.
//

import UIKit

final class PlayerElementListViewCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "PlayerElementListViewCell"

	private var onDelete: (() -> Void)?

	private var mainStackUIEdgeInset: UIEdgeInsets = Constants.mainStackUIEdgeInset

	// MARK: - Private Properties

	private enum Constants {
		static let stackSpacing: CGFloat = 8

		static let mainStackUIEdgeInset: UIEdgeInsets = .init(
			top: 0,
			left: 0,
			bottom: 8,
			right: 0
		)

		static let badgeWidth: CGFloat = 30
		static let badgeHeight: CGFloat = 23

		static let fontSize: CGFloat = 16
	}

	private let nameLabel: CustomLabel = {
		let label = CustomLabel(text: "")
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		return label
	}()

	private lazy var levelView = BadgeView()

	private lazy var deleteButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.Icon.delete, for: .normal)
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.onDelete?()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var rightStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			levelView,
			deleteButton
		])
		stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = Constants.stackSpacing
		return stack
	}()

	private lazy var mainStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			nameLabel,
			rightStack
		])
		stack.axis = .horizontal
		stack.alignment = .center
		stack.distribution = .equalSpacing
		return stack
	}()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Method

	func configure(
		state: PlayerElementRowState,
		uiEdgeInsets: UIEdgeInsets = Constants.mainStackUIEdgeInset
	) {
		reset()

		mainStackUIEdgeInset = uiEdgeInsets

		switch state {
		case .numbered(let player):
			let prefix = "\(player.index ?? 0). "
			showPlayer(player, prefixNumber: prefix)
		case .numberedWithAction(let player, let deleteAction):
			let prefix = "\(player.index ?? 0). "
			showPlayer(player, prefixNumber: prefix)
			deleteButton.isHidden = false
			onDelete = deleteAction
		case .numberedFreeSpot(let index):
			let prefix = "\(index). "
			showFreeSpot(prefixNumber: prefix)
		case .plain(let player):
			showPlayer(player)
		case .plainWithAction(let player, let deleteAction):
			showPlayer(player)
			deleteButton.isHidden = false
			onDelete = deleteAction
		case .plainFreeSpot:
			showFreeSpot()
		}
	}
}

// MARK: - Private methods

private extension PlayerElementListViewCell {

	func reset() {
		nameLabel.text = ""
		levelView.isHidden = true
		deleteButton.isHidden = true
		onDelete = nil
		mainStackUIEdgeInset = Constants.mainStackUIEdgeInset
	}

	func showPlayer(
		_ model: PlayerElementListViewCellModel,
		prefixNumber: String = ""
	) {
		nameLabel.isHidden = false
		levelView.isHidden = false
		nameLabel.text = prefixNumber + model.name
		levelView.configure(distance: model.level)
		mainStack.pinToSuperviewEdges(insets: mainStackUIEdgeInset)
	}

	func showFreeSpot(prefixNumber: String = "") {
		nameLabel.text = prefixNumber + String(localized: "playerElement.FreeSpot")
		deleteButton.isHidden = true
	}

	func setupUI() {
		contentView.addSubviews(mainStack)
	}

	func setupView() {
		setupUI()

		NSLayoutConstraint.activate([
			levelView.widthAnchor.constraint(equalToConstant: Constants.badgeWidth),
			levelView.heightAnchor.constraint(equalToConstant: Constants.badgeHeight)
		])
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	let maxHeight: CGFloat = 30

	VStack {
		UIViewPreview {
			let cell = PlayerElementListViewCell(style: .default, reuseIdentifier: nil)
			let mockPlayer = Player.mockDefault
			let playerModel = PlayerElementListViewCellModel(
				firstName: mockPlayer.firstName,
				lastName: mockPlayer.lastName,
				level: mockPlayer.level.title,
				index: 1
			)
			let state = PlayerElementRowState.numberedWithAction(player: playerModel) {
				print("deleteAction called")
			}
			cell.configure(state: state)
			return cell
		}
		.frame(maxHeight: maxHeight)

		UIViewPreview {
			let cell = PlayerElementListViewCell(style: .default, reuseIdentifier: nil)
			let mockPlayer = Player.mockDefault
			let playerModel = PlayerElementListViewCellModel(
				firstName: mockPlayer.firstName,
				lastName: mockPlayer.lastName,
				level: mockPlayer.level.title,
				index: 2
			)
			let state = PlayerElementRowState.numbered(player: playerModel)
			cell.configure(state: state)
			return cell
		}
		.frame(maxHeight: maxHeight)

		UIViewPreview {
			let cell = PlayerElementListViewCell(style: .default, reuseIdentifier: nil)
			let state = PlayerElementRowState.numberedFreeSpot(index: 3)
			cell.configure(state: state)
			return cell
		}
		.frame(maxHeight: maxHeight)

		Divider()
			.background(Color(.systemGray4))

		UIViewPreview {
			let cell = PlayerElementListViewCell(style: .default, reuseIdentifier: nil)
			let mockPlayer = Player.mockDefault
			let playerModel = PlayerElementListViewCellModel(
				name: "\(mockPlayer.firstName) \(mockPlayer.lastName)",
				level: mockPlayer.level.title,
				index: nil
			)
			let state = PlayerElementRowState.plainWithAction(player: playerModel) {
				print("deleteAction called")
			}
			cell.configure(state: state)
			return cell
		}
		.frame(maxHeight: maxHeight)

		UIViewPreview {
			let cell = PlayerElementListViewCell(style: .default, reuseIdentifier: nil)
			let mockPlayer = Player.mockDefault
			let playerModel = PlayerElementListViewCellModel(
				name: "\(mockPlayer.firstName) \(mockPlayer.lastName)",
				level: mockPlayer.level.title,
				index: nil
			)
			let state = PlayerElementRowState.plain(player: playerModel)
			cell.configure(state: state)
			return cell
		}
		.frame(maxHeight: maxHeight)

		UIViewPreview {
			let cell = PlayerElementListViewCell(style: .default, reuseIdentifier: nil)
			let state = PlayerElementRowState.plainFreeSpot
			cell.configure(state: state)
			return cell
		}
		.frame(maxHeight: maxHeight)

		Spacer()
	}
	.padding()
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
