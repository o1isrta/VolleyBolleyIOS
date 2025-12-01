//
//  GlassView.swift
//  VolleyBolley
//
//  Created by Егор Партенко on 5. 8. 2025..
//

import UIKit

/// A customizable glass-style background view for UIKit.
///
/// ⚠️ Important:
/// This view is a **fork** and heavily modified version of
/// https://github.com/Chaehui-Seo/CHGlassmorphismView
/// adapted for more flexible configuration and improved behavior
/// in dynamic UIKit layouts.
///
/// 🚫 Not intended as a container:
/// GlassView should be used **only as a visual background**, not as a container
/// for interactive subviews. Add buttons, labels, and other UI elements
/// *on top of it*, not inside it. Internally, GlassView manages layers,
/// blur effects, shadows, and masking; placing interactive elements inside
/// may interfere with clipping, hit-testing, or rendering.
///
/// GlassView renders a translucent, frosted-glass effect using a
/// `UIVisualEffectView` combined with optional inner and outer shadows,
/// rounded corners, and a configurable border. It is designed to be placed
/// behind content where you want a modern glass aesthetic that adapts to
/// size changes and app lifecycle transitions.
///
/// Features:
/// - Adjustable blur density (intensity)
/// - Smooth, configurable corner radius with dynamic layout handling
/// - Inner shadow (inset) and outer shadow (drop shadow)
/// - Optional border with color and thickness
/// - Safe reapplication of blur/intensity on app background/foreground events
///
/// Usage:
/// - Initialize with an optional `GlassConfig`, or rely on `.standard`.
/// - Call `makeGlassEffect(density:cornerRadius:distance:)` to apply or update the look.
/// - Adjust individual components via:
///   - `setBlurDensity(with:)`
///   - `setCornerRadius(_:)`
///   - `setDistance(_:)`
///   - `setBorder(width:color:)`
///
/// Performance:
/// - Uses `UIViewPropertyAnimator` for smooth blur transitions.
/// - Avoids unnecessary redraws by updating layers only when needed.
///
/// Lifecycle:
/// - Listens for foreground/background transitions to preserve blur appearance.
/// - Reapplies configuration in `didMoveToWindow()` when the view is reattached.
///
/// Interaction:
/// - Overrides `hitTest` so touches pass through the glass surface and are handled
///   only by actual interactive subviews placed on top.
/// - The view is fully non-interactive by design.
///
/// Note:
/// - The view's backgroundColor is forced to `.clear` and should not be changed.
///   Use `GlassConfig` parameters to customize appearance instead.
final class GlassView: UIView {

    override var backgroundColor: UIColor? {
        get { .clear }
        set {}
    }

    // MARK: - Private Properties

    private let config: GlassConfig

    private let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    private var blurView = UIVisualEffectView()
    private var animatorCompletionValue: CGFloat = 0.2
    private var cornerRadiusValue: CGFloat = 32
    private var distanceValue: CGFloat = 0
    private var isViewBecameInvisible: Bool = false

    private let backgroundView = UIView()

    lazy var innerShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.shadowColor = config.innerShadowColor
        layer.shadowOffset = config.innerShadowOffset
        layer.shadowOpacity = config.innerShadowOpacity
        layer.cornerRadius = cornerRadiusValue
        return layer
    }()

    // MARK: - initializers

    init(config: GlassConfig = .standard) {
        self.config = config
        super.init(frame: .zero)

        initialize()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    deinit {
        NotificationCenter.default.removeObserver(self)
        animator.pauseAnimation()
        animator.stopAnimation(true)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateInnerShadowPath()
    }

    /// Prevent blur reset while backgrounding
    override func didMoveToWindow() {
        super.didMoveToWindow()

        if window == nil {
            handleViewInvisible()
        } else if window != nil, isViewBecameInvisible {
            DispatchQueue.main.async {
                self.handleViewVisible()
            }
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isHidden || alpha < 0.01 || !isUserInteractionEnabled {
            return nil
        }

        if !self.point(inside: point, with: event) {
            return nil
        }

        for subview in subviews.reversed() {
            let pointInSubview = subview.convert(point, from: self)
            if let result = subview.hitTest(pointInSubview, with: event) {
                return result
            }
        }

        return nil
    }

    // MARK: - Public Methods

    func makeGlassEffect(
        density: CGFloat = 0.2,
        cornerRadius: CGFloat = 32,
        distance: CGFloat = 0
    ) {
        setTheme()
        setBlurDensity(with: density)
        setCornerRadius(cornerRadius)
        setDistance(distance)
    }

    func setTheme() {
        blurView.effect = nil

        animator.stopAnimation(true)
        animator.addAnimations {
            self.blurView.effect = UIBlurEffect(style: .light)
        }
        animator.fractionComplete = animatorCompletionValue

        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }

    func setBlurDensity(with density: CGFloat) {
        animatorCompletionValue = density
        animator.fractionComplete = animatorCompletionValue
    }

    func setCornerRadius(_ value: CGFloat) {
        cornerRadiusValue = value
        backgroundView.layer.cornerRadius = value
        blurView.layer.cornerRadius = value
        updateInnerShadowPath()
    }

    func setDistance(_ value: CGFloat) {
        self.distanceValue = value
        var distance = value
        if value < 0 {
            distance = 0
        } else if value > 100 {
            distance = 100
        }
        self.backgroundView.layer.shadowRadius = distance
    }

    func setBorder(width: CGFloat, color: UIColor) {
        backgroundView.layer.borderWidth = width
        backgroundView.layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    private func observeAppState() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleViewVisible),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleViewInvisible),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }

    // MARK: - Private Methods

    private func initialize() {
        cornerRadiusValue = config.cornerRadius

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(backgroundView, at: 0)
        backgroundView.layer.borderWidth = config.borderWidth
        backgroundView.layer.borderColor = config.borderColor
        backgroundView.layer.cornerRadius = config.cornerRadius
        backgroundView.clipsToBounds = true
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.shadowColor = config.outerShadowColor
        backgroundView.layer.shadowOffset = config.outerShadowOffset
        backgroundView.layer.shadowOpacity = config.outerShadowOpacity
        backgroundView.layer.shadowRadius = config.outerShadowRadius

        blurView.layer.masksToBounds = true
        blurView.layer.cornerRadius = config.cornerRadius
        blurView.backgroundColor = config.tintedBackgroundColor
        blurView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.insertSubview(blurView, at: 0)

        innerShadowLayer.cornerRadius = cornerRadiusValue
        layer.addSublayer(innerShadowLayer)
        layer.cornerRadius = config.cornerRadius
        layer.masksToBounds = true

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])

        animatorCompletionValue = config.blurDensity

        animator.addAnimations {
            self.blurView.effect = UIBlurEffect(style: .light)
        }
        animator.fractionComplete = animatorCompletionValue

        observeAppState()
    }

    private func updateInnerShadowPath() {
        innerShadowLayer.frame = bounds

        let safeRadius = min(
            config.innerShadowRadius,
            bounds.height / 2,
            bounds.width / 2
        )
        let offset = config.innerShadowOffset
        let outerRect = bounds.insetBy(dx: -safeRadius*1.5, dy: -safeRadius*1.5)
        let outerPath = UIBezierPath(
            roundedRect: outerRect,
            cornerRadius: cornerRadiusValue + safeRadius
        )

        let innerPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadiusValue
        ).reversing()

        outerPath.append(innerPath)
        innerShadowLayer.path = outerPath.cgPath
        innerShadowLayer.fillRule = .evenOdd

        innerShadowLayer.shadowColor = config.innerShadowColor
        innerShadowLayer.shadowOpacity = config.innerShadowOpacity
        innerShadowLayer.shadowRadius = safeRadius
        innerShadowLayer.shadowOffset = offset
        innerShadowLayer.cornerRadius = cornerRadiusValue
        innerShadowLayer.masksToBounds = false
    }

    // MARK: - Actions

    @objc private func handleViewVisible() {
        if isViewBecameInvisible {
            DispatchQueue.main.async {
                self.makeGlassEffect(
                    density: self.animatorCompletionValue,
                    cornerRadius: self.cornerRadiusValue,
                    distance: self.distanceValue
                )
            }
        }
    }

    @objc private func handleViewInvisible() {
        isViewBecameInvisible = true
    }
}
