//
//  ProgressHub.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 08.09.2025.
//

import UIKit

/// A reusable, singleton-backed loading overlay view that displays a spinning,
/// gradient-masked volleyball icon centered within its bounds.
///
/// ProgressHub is designed to be added as a full-screen subview over any
/// container view to indicate ongoing work. It supports:
/// - Optional blurred background using a system material blur
/// - Two preset icon sizes (big/small)
/// - A continuous spin animation for the icon
///
/// Usage:
/// - Call `ProgressHub.shared.show(in:)` to present with default options.
/// - Use the overloads to customize blur and ball size.
/// - Call `ProgressHub.shared.hide()` to dismiss.
///
/// Threading:
/// - Presentation (`show`) is dispatched to the main queue and is safe to call
///   from background threads.
///
/// Animation:
/// - Applies a CABasicAnimation rotating the gradient-masked layer infinitely.
///
/// Visuals:
/// - The volleyball icon is used as a mask over a vertical green gradient,
///   creating a tinted, animated symbol.
/// - When `withBlur` is enabled, a thin material dark blur is shown behind the icon.
///
/// Notes:
/// - The view intercepts user interaction while visible (`isUserInteractionEnabled = true`)
///   to prevent interaction with underlying content during loading.
/// - The view animates its alpha when showing and hiding.
/// - Constraints are applied to stretch the overlay to its superview, with the icon
///   centered and sized according to `BallSize`.
final class ProgressHub: UIView {

    static let shared = ProgressHub()

    enum BallSize {
        case big
        case small

        var value: CGSize {
            switch self {
            case .big:
                return CGSize(width: 44, height: 44)
            case .small:
                return CGSize(width: 20, height: 20)
            }
        }
    }

    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemThinMaterialDark)
        let visualEffect = UIVisualEffectView(effect: effect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        return visualEffect
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let ballImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.Icon.players)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            AppColor.Gradient.greenLightStart.cgColor,
            AppColor.Gradient.greenLightEnd.cgColor
        ]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.locations = [0.0, 1.0]
        return layer
    }()

    private let maskLayer = CALayer()

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    var withBlur: Bool = true {
        didSet {
            updateBlurAppearance()
        }
    }

    var ballSize: BallSize = .big {
        didSet {
            updateBallSize()
        }
    }

    // MARK: - Init

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupView() {
        alpha = 0
        isUserInteractionEnabled = true
        backgroundColor = AppColor.Background.blur

        addSubview(blurView)
        addSubview(containerView)

        containerView.layer.addSublayer(gradientLayer)

        if let image = UIImage.Icon.players.cgImage {
            maskLayer.contents = image
            maskLayer.contentsGravity = .resizeAspect
            gradientLayer.mask = maskLayer
        }

        updateBlurAppearance()
    }

    private func updateBlurAppearance() {
        blurView.alpha = withBlur ? 0.6 : 0
    }

    private func updateBallSize() {
        let size = ballSize.value
        widthConstraint?.constant = size.width
        heightConstraint?.constant = size.height
        setNeedsLayout()
        layoutIfNeeded()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),

            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        widthConstraint = containerView.widthAnchor.constraint(equalToConstant: ballSize.value.width)
        heightConstraint = containerView.heightAnchor.constraint(equalToConstant: ballSize.value.height)
        widthConstraint?.isActive = true
        heightConstraint?.isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = containerView.bounds
        maskLayer.frame = containerView.bounds
    }

    private func startSpin() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        rotationAnimation.isRemovedOnCompletion = false

        containerView.layer.add(rotationAnimation, forKey: "spinAnimation")
    }

    private func stopSpin() {
        containerView.layer.removeAnimation(forKey: "spinAnimation")
    }

    func show(in view: UIView) {
        show(in: view, withBlur: true, ballSize: .big)
    }

    func show(in view: UIView, withBlur: Bool) {
        show(in: view, withBlur: withBlur, ballSize: .big)
    }

    func show(in view: UIView, ballSize: BallSize) {
        show(in: view, withBlur: true, ballSize: ballSize)
    }

    func show(in view: UIView, withBlur: Bool, ballSize: BallSize) {
        self.withBlur = withBlur
        self.ballSize = ballSize
        showInternal(in: view)
    }

    private func showInternal(in view: UIView) {
        DispatchQueue.main.async {
            if self.superview == nil {
                self.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(self)

                NSLayoutConstraint.activate([
                    self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    self.topAnchor.constraint(equalTo: view.topAnchor),
                    self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])

                self.setNeedsLayout()
                self.layoutIfNeeded()
            }

            self.startSpin()
            UIView.animate(withDuration: 0.2) {
                self.alpha = 1
            }
        }
    }

    func hide() {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.alpha = 0
            },
            completion: { _ in
                self.stopSpin()
                self.removeFromSuperview()
            }
        )
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    LoadingViewPreviewViewController()
}

final class LoadingViewPreviewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        ProgressHub.shared.show(in: view, withBlur: true, ballSize: .big)
    }
}
#endif
