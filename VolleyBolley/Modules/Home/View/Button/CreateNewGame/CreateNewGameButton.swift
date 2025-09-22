//
//  CreateNewGameButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import UIKit

enum CreateNewGameButtonState {
    case locationRestricted
    case withLocationAndWeather(location: LocationTitleViewModel, weather: WeatherViewModel)
    case withLocationOnly(location: LocationTitleViewModel)
}

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
        view.text = "Create a new game"
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
        case .locationRestricted:
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
        top: 100, left: 8, bottom: 100, right: 8
    ))

    let shortCourt = LocationTitleViewModel(
        title: "Karon Beach Club",
        location: "Patak Rd, Mueang Phuket"
    )
    let weather = AppWeather(temperature: 26.0, condition: .partlyCloudy)
    let weatherViewModel = WeatherViewModel(weather: weather)

    let previewStates: [CreateNewGameButtonState] = [
        .locationRestricted,
        .withLocationOnly(location: shortCourt),
        .withLocationAndWeather(location: shortCourt, weather: weatherViewModel)
    ]

    for state in previewStates {
        let button = CreateNewGameButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 116).isActive = true
        button.widthAnchor.constraint(equalToConstant: 361).isActive = true
        button.configure(state: state)
        stackView.addArrangedSubview(button)
    }

    return screenView
}

#endif
