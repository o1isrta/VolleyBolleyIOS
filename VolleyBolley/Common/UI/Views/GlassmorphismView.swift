import UIKit

/// UIView с эффектом "glassmorphism" (размытый прозрачный фон, настраиваемые тени и др.)
class GlassmorphismView: UIView {
    /// Темы оформления blur-эффекта
    public enum Theme {
        case light, dark
    }
    
    // Приватные вложенные представления
    private let blurView = UIVisualEffectView()              // для эффекта размытия фона
    private let animator = UIViewPropertyAnimator(duration: 0, curve: .linear)
    private var animatorFractionComplete: CGFloat = 0.2      // стандартная интенсивность blur (Low Blur)
    
    // MARK: - Настраиваемые свойства (публичные)
    
    /// Радиус скругления углов
    public var cornerRadius: CGFloat = 24 {
        didSet { updateAppearance() }
    }
    /// Цвет границы (с учетом прозрачности)
    public var borderColor: UIColor = UIColor.white.withAlphaComponent(0.3) {
        didSet { updateAppearance() }
    }
    /// Толщина границы
    public var borderWidth: CGFloat = 1.0 {
        didSet { updateAppearance() }
    }
    /// Полупрозрачный цвет фона (overlay поверх размытия)
    public var tintedBackgroundColor: UIColor = UIColor.white.withAlphaComponent(0.05) {
        didSet { updateAppearance() }
    }
    /// Тема (стиль размытия): .light или .dark
    public var theme: Theme = .light {
        didSet { setTheme(theme) }
    }
    /// Интенсивность размытия (0.0 = без размытия, 1.0 = полное размытие)
    public var blurIntensity: CGFloat {
        get { animatorFractionComplete }
        set { setBlurIntensity(newValue) }
    }
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
    /// Прозрачность внешней тени (0...1)
    public var outerShadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    /// Смещение внешней тени
    public var outerShadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    /// Радиус размытия внешней тени (spread)
    public var outerShadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    /// Цвет внутренней тени
    public var innerShadowColor: UIColor = .white {
        didSet { updateInnerShadow() }
    }
    /// Прозрачность внутренней тени (0...1)
    public var innerShadowOpacity: Float = 0.08 {
        didSet { updateInnerShadow() }
    }
    /// Радиус размытия внутренней тени
    public var innerShadowRadius: CGFloat = 6.0 {
        didSet { updateInnerShadow() }
    }
    /// Смещение внутренней тени (для имитации направления света)
    public var innerShadowOffset: CGSize = CGSize(width: 0, height: 4) {
        didSet { updateInnerShadow() }
    }
    
    // Приватный слой для внутренней тени (если используется)
    private var innerShadowLayer: CAShapeLayer?
    
    // MARK: - Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    /// Общие настройки при инициализации
    private func initialize() {
        self.backgroundColor = .clear  // фон самого UIView делаем прозрачным
        
        // Настройка blurView (вложенный UIVisualEffectView для размытия)
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true  // обрезаем содержимое blurView по скругленным углам
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        // Устанавливаем начальный эффект размытия через animator:
        blurView.effect = nil  // пока эффекта нет
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            // Выбираем стиль UIBlurEffect в зависимости от темы
            let style: UIBlurEffect.Style = (self.theme == .dark) ? .dark : .light
            self.blurView.effect = UIBlurEffect(style: style)
        }
        // Применяем эффект размытия (Low Blur по умолчанию)
        animator.fractionComplete = animatorFractionComplete
        
        // Полупрозрачный фон поверх размытия (только contentView, чтобы не влиять на задний фон)
        blurView.contentView.backgroundColor = tintedBackgroundColor
        
        // Добавляем blurView в иерархию
        self.addSubview(blurView)
        // Закрепляем blurView на все границы основного представления
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Настройка границы и внешней тени по умолчанию
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        // Внешняя тень по умолчанию (для эффекта "парения")
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15  // стандартная прозрачность для light theme
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
    }
    
    // MARK: - Методы для обновления параметров
    
    /// Установить интенсивность размытия (0...1)
    public func setBlurIntensity(_ value: CGFloat) {
        // Ограничиваем диапазон от 0 до 1
        let intensity = max(0.0, min(1.0, value))
        animatorFractionComplete = intensity
        animator.fractionComplete = intensity
    }
    
    /// Сменить тему (светлая или темная)
    public func setTheme(_ theme: Theme) {
        // Сбрасываем текущий эффект и останавливаем анимации
        blurView.effect = nil
        animator.stopAnimation(true)
        // Добавляем новую анимацию смены стиля UIBlurEffect
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            let style: UIBlurEffect.Style = (theme == .dark) ? .dark : .light
            self.blurView.effect = UIBlurEffect(style: style)
        }
        // Применяем текущую интенсивность размытия к новому эффекту
        animator.fractionComplete = animatorFractionComplete
        
        // Обновляем цвет границы в зависимости от темы
        borderColor = UIColor.white.withAlphaComponent(theme == .light ? 0.3 : 0.2)
        
        // Обновляем внешнюю тень в зависимости от темы
        layer.shadowOpacity = theme == .light ? 0.15 : 0.25
    }
    
    /// Обновить внешние свойства (граница, скругление, фон) при изменениях
    private func updateAppearance() {
        // Обновляем скругление углов
        layer.cornerRadius = cornerRadius
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true  // содержимое blurView обрезается по скругленным углам
        
        // Обновляем границу
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
        // Обновляем цвет фонового оттенка на blur-контенте
        blurView.contentView.backgroundColor = tintedBackgroundColor
        
        // Обновляем внутреннюю тень (если активна)
        updateInnerShadow()
    }
    
    /// Создать или обновить слой внутренней тени в соответствии с текущими параметрами
    private func updateInnerShadow() {
        // Если внутреннюю тень не нужно отображать, удаляем ее слой (если был)
        if innerShadowOpacity <= 0 || innerShadowRadius <= 0 {
            innerShadowLayer?.removeFromSuperlayer()
            innerShadowLayer = nil
            // Разрешаем отображать внешнюю тень
            self.layer.masksToBounds = false
            return
        }
        // Создаем слой внутренней тени при первом использовании
        if innerShadowLayer == nil {
            let shadowLayer = CAShapeLayer()
            shadowLayer.fillRule = .evenOdd  // используем правило even-odd для вычитания центра
            innerShadowLayer = shadowLayer
            // Добавляем слой внутренней тени поверх blurView (в слой основного view)
            self.layer.addSublayer(shadowLayer)
        }
        guard let shadowLayer = innerShadowLayer else { return }
        
        // Настраиваем свойства внутренней тени
        shadowLayer.frame = self.bounds
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.shadowColor = innerShadowColor.cgColor
        shadowLayer.shadowOffset = innerShadowOffset
        shadowLayer.shadowOpacity = innerShadowOpacity
        shadowLayer.shadowRadius = innerShadowRadius
        
        // Строим путь: внешний прямоугольник (увеличенный) и вычитаем из него внутренний
        let expandedRect = bounds.insetBy(dx: -innerShadowRadius * 2, dy: -innerShadowRadius * 2)
        let outerPath = UIBezierPath(roundedRect: expandedRect, cornerRadius: cornerRadius + innerShadowRadius * 2)
        let innerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
        outerPath.append(innerPath)
        shadowLayer.path = outerPath.cgPath
        shadowLayer.maskedCorners = layer.maskedCorners  // учитываем скругленные углы (если частичные)
        
        // Включаем маскирование, чтобы тень рисовалась только внутри границ view
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Обеспечиваем, что blurView покрывает всю площадь
        blurView.frame = self.bounds
        // Обновляем геометрию внутренней тени при изменении размеров
        if let shadowLayer = innerShadowLayer {
            shadowLayer.frame = self.bounds
            let expandedRect = bounds.insetBy(dx: -innerShadowRadius * 2, dy: -innerShadowRadius * 2)
            let outerPath = UIBezierPath(roundedRect: expandedRect, cornerRadius: cornerRadius + innerShadowRadius * 2)
            let innerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
            outerPath.append(innerPath)
            shadowLayer.path = outerPath.cgPath
        }
    }
}