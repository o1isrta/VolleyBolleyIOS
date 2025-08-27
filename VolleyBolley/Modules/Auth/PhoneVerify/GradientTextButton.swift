//
//  GradientTextButton.swift
//  VolleyBolley
//
//  Created by Олег Кор on 27.08.2025.
//
import UIKit

import UIKit

final class GradientTextButton: UIControl {
    private let gradientLayer = CAGradientLayer()
    private let titleLabel = UILabel()

    init(title: String, gradientColors: [UIColor]) {
        super.init(frame: .zero)

        // Настраиваем текст с подчеркиванием
        let attributedString = NSAttributedString(
            string: title,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.black // используется для маски
            ]
        )
        titleLabel.attributedText = attributedString
        titleLabel.textAlignment = .center
        titleLabel.isUserInteractionEnabled = false
        addSubview(titleLabel)

        // Настраиваем градиент
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.addSublayer(gradientLayer)

        // Маска = titleLabel.layer
        gradientLayer.mask = titleLabel.layer

        // Реакция на тап
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        titleLabel.frame = bounds
    }

    @objc private func handleTap() {
        sendActions(for: .touchUpInside)
    }
}
