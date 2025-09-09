//
//  CreateNewGameButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import UIKit

final class CreateNewGameButton: UIButton {

    // MARK: - Private Properties

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [buttonTitleLabel, hStackView])
        view.axis = .vertical
        view.spacing = 18
        return view
    }()

    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationTitleView, weatherView])
        view.axis = .horizontal
        view.spacing = 18
        return view
    }()

    private lazy var buttonTitleLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.ActayWide.bold(size: 24)
        view.textColor = AppColor.Text.primary
        view.text = String(localized: .homeCreateNewGame)
        return view
    }()

    private lazy var locationTitleView: LocationTitleView = {
        let view = LocationTitleView(type: .icon)
        return view
    }()

    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        return view
    }()

    private lazy var backgroundEffect: GlassmorphismView = {
        let view = GlassmorphismView()
        return view
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        setupLayout()

        var config = UIButton.Configuration.plain()
        config.background.cornerRadius = 16

        self.configuration = config
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: CreateNewGameButtonViewModel) {
        locationTitleView.configure(with: viewModel.locationTitleViewModel)
        weatherView.configure(with: viewModel.weatherViewModel)
    }

    // MARK: - Private Methods

//    private func configuration(for state: UIControl.State) -> UIButton.Configuration {
//        let style = resolveStyle(for: state)
//        var config = UIButton.Configuration.filled()
//
//        config.background.backgroundColor = style.backgroundColor
//        config.background.cornerRadius = style.cornerRadius
//
//        actionTitleLabel.font = style.font
//        actionTitleLabel.textColor = style.titleColor
//        actionImageView.tintColor = style.tintColor
//
//        return config
//    }

//    private func attributedTitle(
//        title: String,
//        color: UIColor,
//        font: UIFont
//    ) -> AttributedString {
//        var attributes = AttributeContainer()
//        attributes.foregroundColor = color
//        attributes.font = font
//        return AttributedString(title, attributes: attributes)
//    }
//
//    private func resolveStyle(for state: UIControl.State) -> SketchButtonStyle {
//        switch (state.contains(.selected), state.contains(.highlighted)) {
//        case (true, true): return SketchButtonStateStyle.highlightedSelected.style
//        case (true, false): return SketchButtonStateStyle.selected.style
//        case (false, true): return SketchButtonStateStyle.highlightedNormal.style
//        default: return SketchButtonStateStyle.normal.style
//        }
//    }

    // MARK: - Layout

    private func setupLayout() {
        addSubview(backgroundEffect)
        addSubview(vStackView)

        backgroundEffect.pinToSuperviewEdges()
        vStackView.pinToSuperviewEdges(insets: UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18))
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
