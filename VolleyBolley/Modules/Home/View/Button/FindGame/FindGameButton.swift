//
//  FindGameButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.09.2025.
//

import UIKit

final class FindGameButton: UIButton {

    // MARK: - Private Properties

    private var activeBackgroundEffect: UIView?

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [buttonTitleLabel, buttonSubTitleLabel])
        view.axis = .vertical
        view.spacing = 8
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var buttonTitleLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.ActayWide.bold(size: 24)
        view.textColor = AppColor.Text.primary
        view.text = String(localized: .homeFindGame)
        return view
    }()

    private lazy var buttonSubTitleLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.Hero.regular(size: 16)
        view.textColor = AppColor.Text.primary
        view.text = String(localized: .homeNearYou)
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        setupLayout()
        gamesAvailableView.configure(with: 12)

        var config = UIButton.Configuration.plain()
        config.background.cornerRadius = 16

        self.configuration = config
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
            buttonImageView.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            buttonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            buttonImageView.widthAnchor.constraint(equalToConstant: 122),
            buttonImageView.heightAnchor.constraint(equalToConstant: 37)
        ])
    }

    private func setupConstraintsGamesAvailableView() {
        NSLayoutConstraint.activate([
            gamesAvailableView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            gamesAvailableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            gamesAvailableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            gamesAvailableView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setupConstraintsVStackView() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            vStackView.trailingAnchor.constraint(equalTo: gamesAvailableView.leadingAnchor, constant: 8)
        ])
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
    UIViewControllerPreview {
        HomeModulePreviewBuilder.build()
    }
    .edgesIgnoringSafeArea(.all)
}
#endif
