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

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                minusButton,
                valueContainer,
                plusButton
            ]
        )
        stack.axis = .horizontal
        stack.spacing = Constants.buttonSpacing
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    // MARK: - Init

    init(type: CounterType) {
        self.type = type
        self.value = type.minValue
        super.init(frame: .zero)
        setupView()
        setupGradientBorder()
        valueLabel.text = "\(value)"
        configureButtonsState(animated: false)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Private Methods

    private func setupView() {
        addSubviews(stackView)
        valueContainer.addSubviews(valueLabel)

        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            minusButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),

            plusButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            plusButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),

            valueContainer.widthAnchor.constraint(equalToConstant: Constants.containerWidth),
            valueContainer.heightAnchor.constraint(equalToConstant: Constants.containerHeight),

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            valueLabel.leadingAnchor.constraint(equalTo: valueContainer.leadingAnchor, constant: 1),
            valueLabel.trailingAnchor.constraint(equalTo: valueContainer.trailingAnchor, constant: -1),
            valueLabel.topAnchor.constraint(equalTo: valueContainer.topAnchor, constant: 1),
            valueLabel.bottomAnchor.constraint(equalTo: valueContainer.bottomAnchor, constant: -1)
        ])

        minusButton.addTarget(self, action: #selector(handleDecrement), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(handleIncrement), for: .touchUpInside)

        setupGradientBorder()
    }

    private func setupGradientBorder() {
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = AppColor.Background.clear.cgColor
        shapeLayer.strokeColor = AppColor.Border.primary.cgColor

        gradientLayer.mask = shapeLayer
        valueContainer.layer.addSublayer(gradientLayer)

        gradientLayer.frame = CGRect(
            x: 0, y: 0,
            width: Constants.containerWidth,
            height: Constants.containerHeight
        )
        shapeLayer.path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: Constants.containerWidth,
                height: Constants.containerHeight
            ).insetBy(dx: 1.5, dy: 1.5),
            cornerRadius: Constants.containerCornerRadius
        ).cgPath
    }

    private func updateValue(animated: Bool) {
        valueLabel.text = "\(value)"
        configureButtonsState(animated: animated)
        valueChanged?(value)
    }

    private func configureButtonsState(animated: Bool) {
        let isAtMin = value <= type.minValue
        let isAtMax = value >= type.maxValue
        let duration = animated ? 0.25 : 0.0

        func animate(_ button: UIButton, hide: Bool) {
            if hide {
                UIView.animate(withDuration: duration, animations: {
                    button.alpha = 0
                }, completion: { _ in
                    button.isHidden = true
                })
            } else {
                if button.isHidden {
                    button.isHidden = false
                    button.alpha = 0
                    UIView.animate(withDuration: duration) {
                        button.alpha = 1
                    }
                }
            }
        }

        animate(minusButton, hide: isAtMin)
        animate(plusButton, hide: isAtMax)
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
