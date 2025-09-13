//
//  CreateNewGameButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import UIKit

final class CreateNewGameButton: UIButton {

    // MARK: - Private Properties

    private var activeBackgroundEffect: UIView?

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [buttonTitleLabel, hStackView])
        view.axis = .vertical
        view.spacing = 18
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationTitleView, weatherView])
        view.axis = .horizontal
        view.distribution = .fillProportionally
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
        view.isHidden = true
        return view
    }()

    private lazy var weatherView = WeatherView()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupLayout()
        self.configuration = UIButton.Configuration.filled()
        self.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            button.configuration = self.configuration(for: button.state)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Public Methods

    func configure(state: CreateNewGameButtonState) {
        switch state {
        case .basic:
            locationTitleView.isHidden = true
            weatherView.isHidden = true
        case .withLocationOnly(let locationTitleViewModel):
            locationTitleView.isHidden = false
            locationTitleView.configure(with: locationTitleViewModel)
            weatherView.isHidden = true
        case .withLocationAndWeather(let locationTitleViewModel, let weatherViewModel):
            locationTitleView.isHidden = false
            locationTitleView.configure(with: locationTitleViewModel)
            weatherView.isHidden = false
            weatherView.configure(with: weatherViewModel)
        case .loading:
            locationTitleView.isHidden = true
            weatherView.isHidden = true
        }
    }

    // MARK: - Layout & Style

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

    // MARK: - Private Methods

    private func setupLayout() {
        addSubview(vStackView)

        vStackView.pinToSuperviewEdges(insets: .init(top: 18, left: 18, bottom: 18, right: 18))
    }

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
