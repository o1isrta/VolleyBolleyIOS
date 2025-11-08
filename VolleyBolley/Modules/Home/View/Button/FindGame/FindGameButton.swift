//
//  FindGameButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.09.2025.
//

import UIKit

final class FindGameButton: UIButton {

    // MARK: - Private Properties

    private enum Constants {
        static let stackSpacing: CGFloat = 7
        static let subTitleFontSize: CGFloat = 16
        static let imageTop: CGFloat = 64
        static let imageLeading: CGFloat = 60
        static let imageWidth: CGFloat = 122.scaledByScreenWidth
        static let imageHeight: CGFloat = 37.scaledByScreenHeight
        static let gamesAvailableInset: CGFloat = 8.scaledByScreenHeight
        static let gamesAvailableWidth: CGFloat = 150.scaledByScreenWidth
        static let vStackTop: CGFloat = 18.scaledByScreenHeight
        static let vStackLeading: CGFloat = 18.scaledByScreenWidth
        static let vStackTrailing: CGFloat = 8.scaledByScreenWidth
    }

    private var activeBackgroundEffect: UIView?

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [buttonTitleLabel, buttonSubTitleLabel])
        view.axis = .vertical
        view.spacing = Constants.stackSpacing
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var buttonTitleLabel: CustomTitle = CustomTitle(
        text: String(localized: "homeFindGame"),
        isLarge: true
    )

    private lazy var buttonSubTitleLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.Hero.regular(size: Constants.subTitleFontSize)
        view.textColor = AppColor.Text.primary
        view.text = String(localized: "homeNearYou")
        return view
    }()

    private lazy var buttonImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.Icon.zigzagArrow.withRenderingMode(.alwaysOriginal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var gamesAvailableView: GamesAvailableView = {
        let view = GamesAvailableView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupLayout()
        self.configuration = UIButton.Configuration.plain()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let style = resolveStyle(for: state)
        if let newEffect = style.backgroundEffectProvider?() as? GlassmorphismView {
            newEffect.frame = bounds
            newEffect.cornerRadius = style.cornerRadius
            if activeBackgroundEffect !== newEffect {
                activeBackgroundEffect?.removeFromSuperview()
                insertSubview(newEffect, at: 0)
                activeBackgroundEffect = newEffect
            }
        } else {
            activeBackgroundEffect?.removeFromSuperview()
            activeBackgroundEffect = nil
        }
    }

    // MARK: - Public Methods

    func configure(with gamesAvailable: Int) {
        gamesAvailableView.configure(with: gamesAvailable)
        gamesAvailableView.isHidden = false
    }

    // MARK: - Private Methods

    private func configuration(for state: UIControl.State) -> UIButton.Configuration {
        let style = resolveStyle(for: state)
        var config = UIButton.Configuration.filled()

        config.background.backgroundColor = style.backgroundColor
        config.background.cornerRadius = style.cornerRadius

        return config
    }

    private func resolveStyle(for state: UIControl.State) -> SketchButtonStyle {
        switch (state.contains(.selected), state.contains(.highlighted)) {
        case (true, true): return SketchButtonStateStyle.highlightedSelected.style
        case (true, false): return SketchButtonStateStyle.selected.style
        case (false, true): return SketchButtonStateStyle.highlightedNormal.style
        default: return SketchButtonStateStyle.normal.style
        }
    }

    private func setupLayout() {
        addSubviews(
            buttonImageView,
            gamesAvailableView,
            vStackView
        )

        setupConstraintsButtonImageView()
        setupConstraintsGamesAvailableView()
        setupConstraintsVStackView()
    }

    // MARK: - Constraints

    private func setupConstraintsButtonImageView() {
        NSLayoutConstraint.activate([
            buttonImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.imageTop),
            buttonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.imageLeading),
            buttonImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            buttonImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }

    private func setupConstraintsGamesAvailableView() {
        NSLayoutConstraint.activate([
            gamesAvailableView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.gamesAvailableInset),
            gamesAvailableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.gamesAvailableInset),
            gamesAvailableView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.gamesAvailableInset
            ),
            gamesAvailableView.widthAnchor.constraint(equalToConstant: Constants.gamesAvailableWidth)
        ])
    }

    private func setupConstraintsVStackView() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.vStackTop),
            vStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.vStackLeading
            ),
            vStackView.trailingAnchor.constraint(
                equalTo: gamesAvailableView.leadingAnchor,
                constant: Constants.vStackTrailing
            )
        ])
    }
}

// MARK: - Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview("Button States") {
    let screenView = UIView()
    screenView.backgroundColor = AppColor.Background.screen

    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 16
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false

    screenView.addSubview(stackView)

    stackView.pinToSuperviewEdges(insets: .init(
        top: 50, left: 8, bottom: 50, right: 8
    ))

    let gamesCounts = [0, 12, 101, 0]

    for count in gamesCounts {
        let button = FindGameButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 116).isActive = true
        button.widthAnchor.constraint(equalToConstant: 361).isActive = true

        button.configure(with: count)
        stackView.addArrangedSubview(button)
    }

    return screenView
}
#endif
