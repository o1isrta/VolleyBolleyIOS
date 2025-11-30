//
//  WeatherView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

final class WeatherView: UIView {

    private enum Constants {
        static let stackSpacing: CGFloat = 8
        static let iconPointSize: CGFloat = 24
        static let temperatureFontSize: CGFloat = 16
        static let temperatureLabelHeight: CGFloat = 24
        static let contentInsets = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        static let backgroundSubviewIndex: Int = 0
    }

    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            iconImageView,
            temperatureLabel
        ])
        view.axis = .horizontal
        view.alignment = .bottom
        view.spacing = Constants.stackSpacing
        return view
    }()

    private let iconImageView = UIImageView()

    private let temperatureLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.ActayWide.bold(size: Constants.temperatureFontSize)
        view.textColor = AppColor.Text.primary
        return view
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: WeatherViewModel) {
        let configuration = UIImage.SymbolConfiguration(pointSize: Constants.iconPointSize, weight: .semibold)
        iconImageView.image = viewModel.icon?.applyingSymbolConfiguration(configuration)
        iconImageView.tintColor = AppColor.Icon.primary
        temperatureLabel.text = viewModel.temperatureText
    }

    private func setupUI() {
        addSubview(hStackView)
        hStackView.pinToSuperviewEdges()
    }
}

// MARK: - Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview() {
    let screenView = UIView()
    screenView.backgroundColor = AppColor.Background.screen

    let view = WeatherView()
    let appWeather = AppWeather(temperature: 26.0, condition: .partlyCloudy)
    let viewModel = WeatherViewModel(weather: appWeather)
    screenView.addSubviews(view)
    view.centerXAnchor.constraint(equalTo: screenView.centerXAnchor).isActive = true
    view.centerYAnchor.constraint(equalTo: screenView.centerYAnchor).isActive = true

    view.configure(with: viewModel)

    return screenView
}
#endif
