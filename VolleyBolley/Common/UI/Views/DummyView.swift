//
//  DummyView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.08.2025.
//

import UIKit

// MARK: - DummyViewType

enum DummyViewType: CaseIterable {
	case noInvites
	case noGames
	case noUpcomingGames
	case noArchivedGames

	var description: String {
		switch self {
		case .noInvites:
			return String(localized: "dummyView.noInvites.description")
		case .noGames:
			return String(localized: "dummyView.noGames.description")
		case .noUpcomingGames:
			return String(localized: "dummyView.noUpcomingGames.description")
		case .noArchivedGames:
			return String(localized: "dummyView.noArchivedGames.description")
		}
	}

	var message: String {
		switch self {
		case .noInvites, .noUpcomingGames:
			return String(localized: "dummyView.noInvites.message")
		case .noGames, .noArchivedGames:
			return String(localized: "dummyView.noGames.message")
		}
	}

	var buttonTitle: String {
		switch self {
		case .noInvites, .noUpcomingGames:
			return String(localized: "dummyView.noInvites.buttonTitle")
		case .noGames, .noArchivedGames:
			return String(localized: "dummyView.noGames.buttonTitle")
		}
	}
}

// MARK: - DummyView

final class DummyView: UIView {

	// MARK: - Public Properties

	var doneButtonCallback: (() -> Void)?

	// MARK: - Private Properties

	private var dummyViewType: DummyViewType

	private lazy var imageView: UIImageView = {
		let image = UIImage(named: "bad_grade")
		let imageView = UIImageView(image: image)
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.text = dummyViewType.description
		return label
	}()

	private lazy var messageLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.text = dummyViewType.message
		return label
	}()

	private lazy var descriptionStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [descriptionLabel, messageLabel])
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .equalCentering
		return stackView
	}()

	// TODO: refactoring
	private lazy var doneButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitleColor(AppColor.Text.inverted, for: .normal)
		button.setTitle(dummyViewType.buttonTitle, for: .normal)
		button.titleLabel?.font = AppFont.ActayWide.bold(size: 16)
		button.backgroundColor = AppColor.Background.actionButtonDefault
		button.layer.cornerRadius = 16
		button.layer.masksToBounds = true
		button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
		return button
	}()

	// MARK: - Initializers

	init(type: DummyViewType) {
		self.dummyViewType = type
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private Methods

private extension DummyView {

	@objc func doneButtonTapped() {
		doneButtonCallback?()
	}

	func setupUI() {
		addSubviews(
			imageView,
			descriptionStackView,
			doneButton
		)

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor, constant: 11),
			imageView.heightAnchor.constraint(equalToConstant: 162),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),

			descriptionStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15.5),
			descriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor),

			doneButton.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 26),
			doneButton.heightAnchor.constraint(equalToConstant: 44),
			doneButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			doneButton.trailingAnchor.constraint(equalTo: trailingAnchor),
			doneButton.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

#if DEBUG
import SwiftUI

struct UIViewPreview<View: UIView>: UIViewRepresentable {
	let view: View

	init(_ builder: @escaping () -> View) {
		view = builder()
	}

	// MARK: - UIViewRepresentable
	func makeUIView(context: Context) -> View {
		return view
	}

	func updateUIView(_ uiView: View, context: Context) {
		uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
		uiView.setContentHuggingPriority(.defaultLow, for: .vertical)
	}
}

@available(iOS 17.0, *)
#Preview {
	UIViewPreview {
		let view = DummyView(type: .noInvites)
		return view
	}
	.frame(width: .infinity, height: 296)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()

	UIViewPreview {
		let view = DummyView(type: .noArchivedGames)
		return view
	}
	.frame(width: .infinity, height: 296)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
