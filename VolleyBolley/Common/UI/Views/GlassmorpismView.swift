//
//  GlassmorpismView.swift
//  VolleyBolley
//
//  Created by Егор Партенко on 5. 8. 2025..
//

import UIKit

/// UIView с эффектом "glassmorphism" - полупрозрачное размытое стекло с настраиваемыми тенями и границами
class GlassmorphismView: UIView {
    
    /// Темы оформления blur-эффекта
    public enum Theme {
        case light, dark
    }
    
    // MARK: - Private Properties
    
    /// Основной компонент для создания эффекта размытия фона
    private let blurView = UIVisualEffectView()
    
    /// Аниматор для плавного управления интенсивностью blur-эффекта
    private let animator = UIViewPropertyAnimator(duration: 0, curve: .linear)
    
    /// Текущая интенсивность размытия (0.2 = слабое размытие по умолчанию)
    private var animatorFractionComplete: CGFloat = 0.2
    
    /// Слой для отрисовки внутренней тени (создается по требованию)
    private var innerShadowLayer: CAShapeLayer?
    
    // MARK: - Public Properties - Geometry
    
    /// Радиус скругления углов
    public var cornerRadius: CGFloat = 24 {
        didSet { updateAppearance() }
    }
    
    /// Цвет границы (рекомендуется использовать полупрозрачный белый)
    public var borderColor: UIColor = UIColor.white.withAlphaComponent(0.15) {
        didSet { updateAppearance() }
    }
    
    /// Толщина границы в points
    public var borderWidth: CGFloat = 1.0 {
        didSet { updateAppearance() }
    }
    
    // MARK: - Public Properties - Blur & Background
    
    /// Полупрозрачный цвет фона поверх размытия для дополнительного тонирования
    public var tintedBackgroundColor: UIColor = UIColor.white.withAlphaComponent(0.07) {
        didSet { updateAppearance() }
    }
    
    /// Тема размытия - определяет светлый или темный стиль UIBlurEffect
    public var theme: Theme = .light {
        didSet { setTheme(theme) }
    }
    
    /// Интенсивность размытия (0.0 = без размытия, 1.0 = полное размытие)
    public var blurIntensity: CGFloat {
        get { animatorFractionComplete }
        set { setBlurIntensity(newValue) }
    }
    
    // MARK: - Public Properties - Outer Shadow
    
    /// Цвет внешней тени (drop shadow)
    public var outerShadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// Прозрачность внешней тени (0.0 - 1.0)
    public var outerShadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    /// Смещение внешней тени (x, y в points)
    public var outerShadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    /// Радиус размытия внешней тени
    public var outerShadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    // MARK: - Public Properties - Inner Shadow
    
    /// Цвет внутренней тени (обычно светлый для эффекта подсветки)
    public var innerShadowColor: UIColor = .white {
        didSet { updateInnerShadow() }
    }
    
    /// Прозрачность внутренней тени (0.0 - 1.0)
    public var innerShadowOpacity: Float = 0.3 {
        didSet { updateInnerShadow() }
    }
    
    /// Радиус размытия внутренней тени
    public var innerShadowRadius: CGFloat = 18.0 {
        didSet { updateInnerShadow() }
    }
    
    /// Смещение внутренней тени для имитации направления света
    public var innerShadowOffset: CGSize = CGSize(width: 0, height: -16) {
        didSet { updateInnerShadow() }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    /// Выполняет первоначальную настройку всех компонентов glassmorphism эффекта
    private func initialize() {
        // Делаем основной view прозрачным - весь эффект создается через blurView
        backgroundColor = .clear
        
        // Настройка blur компонента
        setupBlurView()
        
        // Настройка основных визуальных свойств (граница, тень)
        setupInitialAppearance()
    }
    
    /// Настраивает UIVisualEffectView для создания blur эффекта
    private func setupBlurView() {
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true // Обрезаем blur по границам скругления
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем animator для управления интенсивностью размытия
        // Сначала убираем эффект, затем добавляем его через animator
        blurView.effect = nil
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            let style: UIBlurEffect.Style = (self.theme == .dark) ? .dark : .light
            self.blurView.effect = UIBlurEffect(style: style)
        }
        // Устанавливаем начальную интенсивность
        animator.fractionComplete = animatorFractionComplete
        
        // Добавляем тонирующий слой поверх размытия
        blurView.contentView.backgroundColor = tintedBackgroundColor
        
        // Встраиваем blur в иерархию view
        addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    /// Устанавливает начальные значения для границ и внешней тени
    private func setupInitialAppearance() {
        // Настройка границы на основном layer
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
        // Настройка внешней тени по умолчанию для эффекта "парения"
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
    }
    
    // MARK: - Public Methods
    
    /// Устанавливает интенсивность размытия с проверкой диапазона
    /// - Parameter value: Значение от 0.0 до 1.0
    public func setBlurIntensity(_ value: CGFloat) {
        let intensity = max(0.0, min(1.0, value))
        animatorFractionComplete = intensity
        animator.fractionComplete = intensity
    }
    
    /// Переключает тему оформления и автоматически подстраивает цвета
    /// - Parameter theme: Светлая или темная тема
    public func setTheme(_ theme: Theme) {
        // Сбрасываем текущий эффект размытия
        blurView.effect = nil
        animator.stopAnimation(true)
        
        // Создаем новый animator с соответствующим стилем blur
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            let style: UIBlurEffect.Style = (theme == .dark) ? .dark : .light
            self.blurView.effect = UIBlurEffect(style: style)
        }
        // Восстанавливаем сохраненную интенсивность
        animator.fractionComplete = animatorFractionComplete
        
        // Автоматически подстраиваем цвета под тему
        borderColor = UIColor.white.withAlphaComponent(theme == .light ? 0.15 : 0.1)
        layer.shadowOpacity = theme == .light ? 0.15 : 0.25
    }
    
    // MARK: - Private Methods
    
    /// Обновляет все визуальные свойства при изменении параметров
    private func updateAppearance() {
        // Синхронизируем скругление между основным view и blur view
        layer.cornerRadius = cornerRadius
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true
        
        // Обновляем границу
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
        // Обновляем цвет тонирующего слоя
        blurView.contentView.backgroundColor = tintedBackgroundColor
        
        // Пересчитываем внутреннюю тень с новыми параметрами
        updateInnerShadow()
    }
    
    /// Создает или обновляет слой внутренней тени
    /// Использует технику "вырезания" для имитации тени внутри границ view
    private func updateInnerShadow() {
        // Если тень не нужна, удаляем слой и разрешаем внешнюю тень
        if innerShadowOpacity <= 0 || innerShadowRadius <= 0 {
            innerShadowLayer?.removeFromSuperlayer()
            innerShadowLayer = nil
            layer.masksToBounds = false
            return
        }
        
        // Создаем слой при первом использовании
        if innerShadowLayer == nil {
            let shadowLayer = CAShapeLayer()
            shadowLayer.fillRule = .evenOdd // Для техники "вырезания"
            innerShadowLayer = shadowLayer
            layer.addSublayer(shadowLayer)
        }
        
        guard let shadowLayer = innerShadowLayer else { return }
        
        // Настраиваем геометрию и свойства тени
        shadowLayer.frame = bounds
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.shadowColor = innerShadowColor.cgColor
        shadowLayer.shadowOffset = innerShadowOffset
        shadowLayer.shadowOpacity = innerShadowOpacity
        shadowLayer.shadowRadius = innerShadowRadius
        
        // Создаем составной путь: большой внешний прямоугольник минус внутренний
        // Это позволяет тени отображаться только по внутреннему периметру
        let expandedRect = bounds.insetBy(dx: -innerShadowRadius * 2, dy: -innerShadowRadius * 2)
        let outerPath = UIBezierPath(roundedRect: expandedRect, cornerRadius: cornerRadius + innerShadowRadius * 2)
        let innerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
        outerPath.append(innerPath)
        shadowLayer.path = outerPath.cgPath
        shadowLayer.maskedCorners = layer.maskedCorners
        
        // Включаем маскирование для ограничения тени границами view
        layer.masksToBounds = true
    }
    
    // MARK: - UIView Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Убеждаемся, что blur покрывает всю площадь
        blurView.frame = bounds
        
        // При изменении размеров пересчитываем геометрию внутренней тени
        if let shadowLayer = innerShadowLayer {
            shadowLayer.frame = bounds
            let expandedRect = bounds.insetBy(dx: -innerShadowRadius * 2, dy: -innerShadowRadius * 2)
            let outerPath = UIBezierPath(roundedRect: expandedRect, cornerRadius: cornerRadius + innerShadowRadius * 2)
            let innerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
            outerPath.append(innerPath)
            shadowLayer.path = outerPath.cgPath
        }
    }
}
