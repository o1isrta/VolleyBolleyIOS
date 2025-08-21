//
//  CounterView.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 21.08.2025.
//

import UIKit

/// Тип счетчика: для игроков или для команд
enum CounterType {
    case players
    case teams
    
    var minValue: Int {
        switch self {
        case .players: return Constants.minPlayers
        case .teams: return Constants.minTeams
        }
    }
    
    var maxValue: Int {
        Constants.maxValue
    }
    
    // MARK: - Constants
    private enum Constants {
        static let minPlayers = 4
        static let minTeams = 3
        static let maxValue = 24
    }
}

/// Переиспользуемый счетчик для выбора количества игроков или команд
final class CounterView: UIView {
    
    // MARK: - Public Properties
    var type: CounterType
    var valueChanged: ((Int) -> Void)?
    
    // MARK: - Private Properties
    private var value: Int {
        didSet {
            valueLabel.text = "\(value)"
            updateButtonsState()
            valueChanged?(value)
        }
    }
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("−", for: .normal)
        button.titleLabel?.font = AppFont.Hero.bold(size: 24)
        button.tintColor = .black
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = AppFont.Hero.bold(size: 24)
        button.tintColor = .black
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        return button
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = AppFont.Hero.bold(size: 20)
        label.textColor = AppColor.Text.primary
        label.layer.cornerRadius = 12
        label.layer.borderWidth = 1
        label.layer.borderColor = AppColor.Border.primary.cgColor
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - Initializers
    init(type: CounterType, initialValue: Int) {
        self.type = type
        self.value = initialValue
        super.init(frame: .zero)
        setupView()
        updateButtonsState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(minusButton)
        addSubview(valueLabel)
        addSubview(plusButton)
        
        minusButton.addTarget(self, action: #selector(handleDecrement), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(handleIncrement), for: .touchUpInside)
        
        valueLabel.text = "\(value)"
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: 44),
            minusButton.heightAnchor.constraint(equalToConstant: 44),
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 16),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            valueLabel.heightAnchor.constraint(equalToConstant: 44),
            
            plusButton.widthAnchor.constraint(equalToConstant: 44),
            plusButton.heightAnchor.constraint(equalToConstant: 44),
            plusButton.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 16),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        applyGradient(to: minusButton)
        applyGradient(to: plusButton)
    }
    
    // MARK: - Private Methods
    private func updateButtonsState() {
        minusButton.isEnabled = value > type.minValue
        plusButton.isEnabled = value < type.maxValue
        
        minusButton.alpha = minusButton.isEnabled ? 1.0 : 0.5
        plusButton.alpha = plusButton.isEnabled ? 1.0 : 0.5
    }
    
    private func applyGradient(to button: UIButton) {
        let gradient = CAGradientLayer()
        gradient.colors = [
            AppColor.Gradient.greenLightStart.cgColor,
            AppColor.Gradient.greenLightEnd.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        gradient.cornerRadius = 22
        button.layer.insertSublayer(gradient, at: 0)
    }
    
    @objc
    private func handleDecrement() {
        if value > type.minValue {
            value -= 1
        }
    }
    
    @objc
    private func handleIncrement() {
        if value < type.maxValue {
            value += 1
        }
    }
}

