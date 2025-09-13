//
//  WeatherView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

final class WeatherView: UIView {

    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, temperatureLabel])
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.spacing = 2
        return stackView
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = AppColor.Icon.primary
        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.ActayWide.bold(size: 16)
        label.textColor = AppColor.Text.primary
        return label
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
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        iconImageView.image = viewModel.icon?.applyingSymbolConfiguration(configuration)
        temperatureLabel.text = viewModel.temperatureText
    }

    private func setupUI() {
        addSubview(hStackView)
        hStackView.pinToSuperviewEdges()
        temperatureLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }
}
