//
//  GradientLabel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 02.10.2025.
//

import UIKit

class GradientLabel: UILabel {

	private let gradientLayer = CALayer.getGradientLayer()

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}

	override func draw(_ rect: CGRect) {
		// Создаём изображение с текстом (в виде маски)
		let textImage = textAsImage()
		// Применяем маску к градиенту
		gradientLayer.mask = CALayer()
		gradientLayer.mask?.contents = textImage.cgImage
		gradientLayer.mask?.frame = bounds
		// Добавляем градиентный слой поверх
		if gradientLayer.superlayer == nil {
			layer.addSublayer(gradientLayer)
		}
		// Скрываем оригинальный текст (делаем его прозрачным)
		textColor = UIColor.clear
	}

	private func textAsImage() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
		defer { UIGraphicsEndImageContext() }
		// Восстанавливаем оригинальный цвет текста временно для рендера
		let originalColor = textColor
		textColor = AppColor.Background.primary // или белый — неважно, главное контраст
		drawText(in: bounds)
		textColor = originalColor

		return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
	}
}
