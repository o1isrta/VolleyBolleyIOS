//
//  WeatherView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

final class WeatherView: UIView {

    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let shimmerView = UIView()

    private var isLoading = false {
        didSet {
            updateLoadingState()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        updateLoadingState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        updateLoadingState()
    }

    func configure(condition: WeatherCondition, temperature: Double) {
        isLoading = false

        iconImageView.image = condition.icon
        let temp = Locale.current.usesFahrenheit
            ? temperature * 9 / 5 + 32
            : temperature
        let unit = Locale.current.usesFahrenheit ? "℉" : "℃"

        temperatureLabel.text = "\(Int(round(temp)))\(unit)"
    }

    func showLoading() {
        isLoading = true
    }

    // MARK: - Private

    private func setupUI() {
        iconImageView.tintColor = .label
        temperatureLabel.font = .systemFont(ofSize: 14)
        temperatureLabel.textColor = .label

        let stack = UIStackView(arrangedSubviews: [iconImageView, temperatureLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        shimmerView.backgroundColor = UIColor.secondarySystemFill
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        shimmerView.layer.cornerRadius = 4
        shimmerView.isHidden = true
        addSubview(shimmerView)

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),

            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),

            shimmerView.topAnchor.constraint(equalTo: topAnchor),
            shimmerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shimmerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shimmerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func updateLoadingState() {
        iconImageView.isHidden = isLoading
        temperatureLabel.isHidden = isLoading
        shimmerView.isHidden = !isLoading

        if isLoading {
            startShimmer()
        } else {
            stopShimmer()
        }
    }

    private func startShimmer() {
        let shimmer = CABasicAnimation(keyPath: "opacity")
        shimmer.fromValue = 1
        shimmer.toValue = 0.3
        shimmer.duration = 0.8
        shimmer.repeatCount = .infinity
        shimmer.autoreverses = true
        shimmerView.layer.add(shimmer, forKey: "shimmer")
    }

    private func stopShimmer() {
        shimmerView.layer.removeAnimation(forKey: "shimmer")
    }
}

