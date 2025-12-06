//
//  CreateNewGameButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import UIKit

enum CreateNewGameButtonState {
    case locationRestricted
    case withCourtAndWeather(court: LocationTitleViewModel, weather: WeatherViewModel)
    case withCourtOnly(court: LocationTitleViewModel)
}

final class CreateNewGameButton: UIButton {

    // MARK: - Private Properties

    private enum Constants {
        static let stackSpacing: CGFloat = 18
        static let contentInsets = UIEdgeInsets(top: 20, left: 18, bottom: 20, right: 18)
        static let backgroundSubviewIndex: Int = 0
    }

    private let glassView = GlassView(config: .sketch)

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [buttonTitleLabel, hStackView])
        view.axis = .vertical
        view.spacing = Constants.stackSpacing
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var hStackView: UIStackView = {
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let view = UIStackView(arrangedSubviews: [
            locationTitleView, spacer, weatherView
        ])
        view.axis = .horizontal
        view.alignment = .bottom
        view.distribution = .fill
        return view
    }()

    private let buttonTitleLabel = CustomTitle(
        text: String(localized: "homeCreateNewGame"),
        isLarge: true
    )

    private let locationTitleView = LocationTitleView(type: .icon)
    private let weatherView = WeatherView()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupLayout()

        clipsToBounds = true

        self.configuration = UIButton.Configuration.filled()
        self.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            button.configuration = self.configuration(for: button.state)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(state: CreateNewGameButtonState) {
        switch state {
        case .locationRestricted:
            locationTitleView.isHidden = true
            weatherView.isHidden = true
        case .withCourtOnly(let locationTitleViewModel):
            locationTitleView.isHidden = false
            locationTitleView.configure(with: locationTitleViewModel)
            weatherView.isHidden = true
        case .withCourtAndWeather(let locationTitleViewModel, let weatherViewModel):
            locationTitleView.isHidden = false
            locationTitleView.configure(with: locationTitleViewModel)
            weatherView.isHidden = false
            weatherView.configure(with: weatherViewModel)
        }
    }

    // MARK: - Private Methods

    private func configuration(for state: UIControl.State) -> UIButton.Configuration {
        let style = resolveStyle(for: state)
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = style.backgroundColor
        config.background.cornerRadius = style.cornerRadius

        glassView.alpha = style.glassAlpha

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
        addSubviews(glassView, vStackView)
        glassView.isUserInteractionEnabled = false

        glassView.pinToSuperviewEdges()
        vStackView.pinToSuperviewEdges(insets: Constants.contentInsets)
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
        .withCourtOnly(court: shortCourt),
        .withCourtAndWeather(court: shortCourt, weather: weatherViewModel)
    ]

    for state in previewStates {
        let button = CreateNewGameButton()
        button.heightAnchor.constraint(equalToConstant: 116).isActive = true
        button.widthAnchor.constraint(equalToConstant: 361).isActive = true
        button.configure(state: state)
        stackView.addArrangedSubview(button)
    }

    return screenView
}

#endif
