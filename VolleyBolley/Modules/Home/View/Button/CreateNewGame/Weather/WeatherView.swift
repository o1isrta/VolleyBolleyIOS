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
        stackView.alignment = .center
        stackView.spacing = 1
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
        iconImageView.image = viewModel.icon
        temperatureLabel.text = viewModel.temperatureText
    }

    private func setupUI() {
        addSubview(hStackView)
        hStackView.pinToSuperviewEdges()

//        NSLayoutConstraint.activate([
//            iconImageView.widthAnchor.constraint(equalToConstant: 20),
//            iconImageView.heightAnchor.constraint(equalToConstant: 20)
//        ])
    }
}
