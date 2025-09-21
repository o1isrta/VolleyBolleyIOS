//
//  GlassmorpismView.swift
//  VolleyBolley
//
//  Created by Егор Партенко on 5. 8. 2025..
//

import UIKit

/// UIView с эффектом "glassmorphism" - полупрозрачное размытое стекло с настраиваемыми тенями и границами
class GlassmorphismView: UIView {

    enum Theme {
        case light, dark
    }

    enum Style {
        case standartGlass
        case notificationGlass
    }

    // MARK: - Public Properties

    var cornerRadius: CGFloat = 0 {
        didSet { updateAppearance() }
    }

    var borderColor: UIColor = .clear {
        didSet { updateAppearance() }
    }

    var borderWidth: CGFloat = 0 {
        didSet { updateAppearance() }
    }

    var tintedBackgroundColor: UIColor = .clear {
        didSet { updateAppearance() }
    }

    var theme: Theme = .light {
        didSet { setTheme(theme) }
    }

    var blurIntensity: CGFloat {
        get { animatorFractionComplete }
        set { setBlurIntensity(newValue) }
    }

    var outerShadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    var outerShadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    var outerShadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    var outerShadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    var innerShadowColor: UIColor = AppColor.Glassmorphism.innerShadowColor {
        didSet { updateInnerShadow() }
    }

    var innerShadowOpacity: Float = 0 {
        didSet { updateInnerShadow() }
    }

    var innerShadowRadius: CGFloat = 0 {
        didSet { updateInnerShadow() }
    }

    var innerShadowOffset: CGSize = .zero {
        didSet { updateInnerShadow() }
    }

    // MARK: - Private Properties

    private let blurView = UIVisualEffectView()
    private var animator = UIViewPropertyAnimator(duration: 0, curve: .linear)
    private var animatorFractionComplete: CGFloat = 0.2

    private var innerShadowLayer: CAShapeLayer?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    /// Выполняет первоначальную настройку всех компонентов glassmorphism эффекта
    private func initialize() {
        backgroundColor = .clear
        setupBlurView()
        apply(.standard)
		resetAnimator()
    }

	/// Сбрасывает и пересоздает аниматор
	private func resetAnimator() {
		animator.stopAnimation(true)
		animator = UIViewPropertyAnimator(duration: 0, curve: .linear)
		animator.fractionComplete = animatorFractionComplete
	}

    /// Настраивает UIVisualEffectView для создания blur эффекта
    private func setupBlurView() {
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false

        blurView.effect = nil

        addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    // MARK: - Public Methods

    static func make(style: Style) -> GlassmorphismView {
        switch style {
        case .standartGlass:
            return GlassmorphismView(configuration: .standard)
        case .notificationGlass:
            return GlassmorphismView(configuration: .notification)
        }
    }

    func setBlurIntensity(_ value: CGFloat) {
        let intensity = max(0.0, min(1.0, value))
        animatorFractionComplete = intensity
        animator.fractionComplete = intensity
    }

    func setTheme(_ theme: Theme) {
        blurView.effect = nil
		resetAnimator()

        animator.addAnimations { [weak self] in
            guard let self else { return }
            let style: UIBlurEffect.Style = (theme == .dark) ? .dark : .light
            self.blurView.effect = UIBlurEffect(style: style)
        }
        animator.fractionComplete = animatorFractionComplete
    }

	/// Этот метод следует вызывать при повторном использовании ячеек, чтобы предотвратить накопление слоев.
    func resetForReuse() {
		resetAnimator()
    }

    // MARK: - Private Methods

    /// Обновляет все визуальные свойства при изменении параметров
    private func updateAppearance() {
        layer.cornerRadius = cornerRadius
        blurView.layer.cornerRadius = cornerRadius
        blurView.clipsToBounds = true

        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth

        blurView.contentView.backgroundColor = tintedBackgroundColor

        updateInnerShadow()
    }

    /// Создает или обновляет слой внутренней тени
    /// Использует технику "вырезания" для имитации тени внутри границ view
    private func updateInnerShadow() {
        if innerShadowOpacity <= 0 || innerShadowRadius <= 0 {
            innerShadowLayer?.removeFromSuperlayer()
            innerShadowLayer = nil
            layer.masksToBounds = false
            return
        }

        if innerShadowLayer == nil {
            let shadowLayer = CAShapeLayer()
            shadowLayer.fillRule = .evenOdd
            innerShadowLayer = shadowLayer
            layer.addSublayer(shadowLayer)
        }

        guard let shadowLayer = innerShadowLayer else { return }

        shadowLayer.frame = bounds
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.shadowColor = innerShadowColor.cgColor
        shadowLayer.shadowOffset = innerShadowOffset
        shadowLayer.shadowOpacity = innerShadowOpacity
        shadowLayer.shadowRadius = innerShadowRadius

        let expandedRect = bounds.insetBy(dx: -innerShadowRadius * 2, dy: -innerShadowRadius * 2)
        let outerPath = UIBezierPath(roundedRect: expandedRect, cornerRadius: cornerRadius + innerShadowRadius * 2)
        let innerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
        outerPath.append(innerPath)
        shadowLayer.path = outerPath.cgPath
        shadowLayer.maskedCorners = layer.maskedCorners

        layer.masksToBounds = true
    }

    deinit {
		animator.stopAnimation(false)
		animator.finishAnimation(at: .current)
    }

    // MARK: - UIView Overrides

    override func layoutSubviews() {
        super.layoutSubviews()

        blurView.frame = bounds

		guard let shadowLayer = innerShadowLayer, shadowLayer.superlayer != nil else { return }

		shadowLayer.frame = bounds
		let expandedRect = bounds.insetBy(dx: -innerShadowRadius * 2, dy: -innerShadowRadius * 2)
		let outerPath = UIBezierPath(roundedRect: expandedRect, cornerRadius: cornerRadius + innerShadowRadius * 2)
		let innerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
		outerPath.append(innerPath)
		shadowLayer.path = outerPath.cgPath
    }
}
