//
//  GradientLabel.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 25.08.2025.
//
import UIKit

final class GradientLabel: UIView {
    private let gradientLayer = CAGradientLayer()
        private let textStack = UIStackView()

        init(names: [String], gradientColors: [UIColor]) {
            super.init(frame: .zero)

            textStack.axis = .vertical
            textStack.alignment = .leading
            textStack.spacing = 16

            names.forEach { text in
                let label = UILabel()
                label.text = text
                label.font = AppFont.Hero.bold(size: 16)
                label.textAlignment = .left
                label.textColor = .black // альфа для маски
                textStack.addArrangedSubview(label)
            }

            addSubview(textStack)

            // Градиент
            gradientLayer.colors = gradientColors.map { $0.cgColor }
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            layer.addSublayer(gradientLayer)

            // Маска — текстовый стек
            mask = textStack
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = bounds
            mask?.frame = bounds
        }
}
