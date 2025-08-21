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
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = AppFont.Hero.bold(size: 20)
        label.textColor = AppColor.Text.primary
        label.backgroundColor = .white
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        return label
    }()
    
    private let gradientLayer = CAGradientLayer()
    
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
            minusButton.widthAnchor.constraint(equalToConstant: 16),
            minusButton.heightAnchor.constraint(equalToConstant: 16),
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 8),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: 64),
            valueLabel.heightAnchor.constraint(equalToConstant: 39),
            
            plusButton.widthAnchor.constraint(equalToConstant: 16),
            plusButton.heightAnchor.constraint(equalToConstant: 16),
            plusButton.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        setupGradientBorder()
    }
    
    private func setupGradientBorder() {
        gradientLayer.colors = [
            AppColor.Gradient.greenLightStart.cgColor,
            AppColor.Gradient.greenLightEnd.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 12
        gradientLayer.masksToBounds = true
        
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 64, height: 39), cornerRadius: 12).cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shape
        
        valueLabel.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = valueLabel.bounds
        if let shape = gradientLayer.mask as? CAShapeLayer {
            shape.path = UIBezierPath(roundedRect: valueLabel.bounds, cornerRadius: 12).cgPath
        }
    }
    
    // MARK: - Private Methods
    private func updateButtonsState() {
        minusButton.isEnabled = value > type.minValue
        plusButton.isEnabled = value < type.maxValue
        
        minusButton.alpha = minusButton.isEnabled ? 1.0 : 0.5
        plusButton.alpha = plusButton.isEnabled ? 1.0 : 0.5
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

#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
    UIViewPreview {
        CounterView(type: .players, initialValue: 4)
    }
    .frame(width: 120, height: 39)
    .padding()
    .background(Color.gray)
}
#endif
