//
//  GradientTextButton.swift
//  VolleyBolley
//
//  Created by Олег Кор on 27.08.2025.
//
import UIKit

class GradientTextButton: UIButton {
    var textGradientColors: [CGColor] = [] {
        didSet {
            updateGradientText()
        }
    }
    
    var textGradientStartPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet {
            updateGradientText()
        }
    }
    
    var textGradientEndPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet {
            updateGradientText()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        // Убираем фон кнопки
        backgroundColor = .clear
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        updateGradientText()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientText()
    }
    
    private func updateGradientText() {
        guard let title = currentTitle, !title.isEmpty else { return }
        
        // Создаем градиентное изображение
        let gradientImage = createGradientImage()
        
        // Создаем атрибутированную строку с градиентом
        let attributes: [NSAttributedString.Key: Any] = [
            .font: titleLabel?.font ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(patternImage: gradientImage),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedString, for: .normal)
    }
    
    private func createGradientImage() -> UIImage {
        // Используем фиксированный размер для градиента
        let size = CGSize(width: 200, height: 50)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: size)
        gradientLayer.colors = textGradientColors
        gradientLayer.startPoint = textGradientStartPoint
        gradientLayer.endPoint = textGradientEndPoint
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
        }
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}
