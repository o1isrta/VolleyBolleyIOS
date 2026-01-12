//
//  WeatherView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

final class WeatherView: UIView {

    private enum Constants {
        static let stackSpacing: CGFloat = 5
        static let iconPointSize: CGFloat = 24
        static let temperatureFontSize: CGFloat = 16
        static let temperatureLabelHeight: CGFloat = 24
        static let contentInsets = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        static let backgroundSubviewIndex: Int = 0
    }

    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, temperatureLabel])
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = AppColor.Icon.primary
        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.ActayWide.bold(size: Constants.temperatureFontSize)
        label.textColor = AppColor.Text.primary
        return label
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func configure(with viewModel: WeatherViewModel) {
        let configuration = UIImage.SymbolConfiguration(pointSize: Constants.iconPointSize, weight: .semibold)
        iconImageView.image = viewModel.icon?.applyingSymbolConfiguration(configuration)
        temperatureLabel.text = viewModel.temperatureText
    }

    private func setupUI() {
        addSubview(hStackView)
        hStackView.pinToSuperviewEdges()
        temperatureLabel.heightAnchor.constraint(
            equalToConstant: Constants.temperatureLabelHeight
        ).isActive = true
    }
}
