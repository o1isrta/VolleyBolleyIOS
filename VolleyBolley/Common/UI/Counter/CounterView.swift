//
//  CounterView.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 21.08.2025.
//

import UIKit

enum CounterType {
    case players
    case teams

    var minValue: Int {
        switch self {
        case .players: return Constants.minPlayers
        case .teams: return Constants.minTeams
        }
    }

    var maxValue: Int { Constants.maxValue }

    private enum Constants {
        static let minPlayers = 4
        static let minTeams = 3
        static let maxValue = 24
    }
}

// MARK: - CounterView

final class CounterView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let buttonSize: CGFloat = 16
        static let containerWidth: CGFloat = 63
        static let containerHeight: CGFloat = 39
        static let containerCornerRadius: CGFloat = 16
        static let labelCornerRadius: CGFloat = 18
        static let buttonSpacing: CGFloat = 8
    }

    // MARK: - Public Properties

    var type: CounterType
    var valueChanged: ((Int) -> Void)?
    public var value: Int {
        didSet { updateValue(animated: true) }
    }

    // MARK: - Private Properties

    private let minusButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.minus, for: .normal)
        button.tintColor = AppColor.Text.primary
        return button
    }()

    private let plusButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.plus, for: .normal)
        button.tintColor = AppColor.Text.primary
        return button
    }()

    private let valueContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.containerCornerRadius
        view.layer.masksToBounds = true
        return view
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.inverted
        label.backgroundColor = AppColor.Background.primary
        label.layer.cornerRadius = Constants.labelCornerRadius
        label.layer.masksToBounds = true
        return label
    }()

    private let gradientLayer: CAGradientLayer = CALayer.getGradientLayer()
    private let shapeLayer = CAShapeLayer()

    private var minusLeadingConstraint: NSLayoutConstraint?
    private var valueLeadingConstraint: NSLayoutConstraint?
    private var plusLeadingConstraint: NSLayoutConstraint?

    // MARK: - Initializers

    init(type: CounterType) {
        self.type = type
        self.value = type.minValue
        super.init(frame: .zero)
        setupView()
        valueLabel.text = "\(value)"
        configureButtonsState(animated: false)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Private Methods
    private func setupView() {
        addSubviews(minusButton, valueContainer, plusButton)
        valueContainer.addSubviews(valueLabel)

        minusButton.addTarget(self, action: #selector(handleDecrement), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(handleIncrement), for: .touchUpInside)

        setupConstraints()
        setupGradientBorder()
    }

    private func setupConstraints() {
        let minusLeading = minusButton.leadingAnchor.constraint(equalTo: leadingAnchor)
        let valueLeading = valueContainer.leadingAnchor.constraint(
            equalTo: minusButton.trailingAnchor,
            constant: Constants.buttonSpacing
        )
        let plusLeading = plusButton.leadingAnchor.constraint(
            equalTo: valueContainer.trailingAnchor,
            constant: Constants.buttonSpacing
        )

        self.minusLeadingConstraint = minusLeading
        self.valueLeadingConstraint = valueLeading
        self.plusLeadingConstraint = plusLeading

        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            minusButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            minusLeading,
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            valueContainer.widthAnchor.constraint(equalToConstant: Constants.containerWidth),
            valueContainer.heightAnchor.constraint(equalToConstant: Constants.containerHeight),
            valueContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLeading,

            valueLabel.leadingAnchor.constraint(equalTo: valueContainer.leadingAnchor, constant: 1),
            valueLabel.trailingAnchor.constraint(equalTo: valueContainer.trailingAnchor, constant: -1),
            valueLabel.topAnchor.constraint(equalTo: valueContainer.topAnchor, constant: 1),
            valueLabel.bottomAnchor.constraint(equalTo: valueContainer.bottomAnchor, constant: -1),

            plusButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            plusButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            plusLeading,
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    /// Настройка градиентной обводки для контейнера
    private func setupGradientBorder() {
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = AppColor.Background.clear.cgColor
        shapeLayer.strokeColor = AppColor.Border.primary.cgColor

        gradientLayer.mask = shapeLayer
        valueContainer.layer.addSublayer(gradientLayer)
    }

    private func updateValue(animated: Bool) {
        valueLabel.text = "\(value)"
        configureButtonsState(animated: animated)
        valueChanged?(value)
    }

    /// Обновление состояния кнопок (показ/скрытие + констрейнты)
    private func configureButtonsState(animated: Bool) {
        let isAtMin = value <= type.minValue
        let duration = animated ? 0.25 : 0.0

        UIView.animate(withDuration: duration) {
            self.minusLeadingConstraint?.constant = isAtMin ? -Constants.buttonSize : 0
            self.valueLeadingConstraint?.constant = isAtMin ? 0 : Constants.buttonSpacing
            self.layoutIfNeeded()
        }

        minusButton.isHidden = isAtMin
        plusButton.isHidden = value >= type.maxValue
    }

    // MARK: - Actions

    @objc private func handleDecrement() {
        guard value > type.minValue else { return }
        value -= 1
    }

    @objc private func handleIncrement() {
        guard value < type.maxValue else { return }
        value += 1
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = valueContainer.bounds
        shapeLayer.path = UIBezierPath(
            roundedRect: valueContainer.bounds.insetBy(dx: 1.5, dy: 1.5),
            cornerRadius: valueContainer.layer.cornerRadius
        ).cgPath
    }
}

// MARK: - Preview (Debug only)

import SwiftUI
#if DEBUG
@available(iOS 17.0, *)
#Preview {
    UIViewPreview {
        CounterView(type: .players)
    }
    .frame(width: 120, height: 50)
    .padding()
    .background(Color.gray)
}
#endif
