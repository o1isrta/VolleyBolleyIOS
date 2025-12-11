//
//  LoaderViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 08.09.2025.
//

import UIKit

final class LoaderViewController: UIViewController {

    // MARK: - Private Properties

    private let containerView = UIView()
    private let gradientLayer = CAGradientLayer()
    private let maskLayer = CALayer()

    private lazy var volleyballImage: CGImage? = {
        let config = UIImage.SymbolConfiguration(pointSize: 44, weight: .regular)
        return UIImage.volleyball?.withConfiguration(config).cgImage
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSpin()
        animateIn()

        UIAccessibility.post(notification: .screenChanged, argument: "Loading")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopSpin()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = containerView.bounds
        maskLayer.frame = containerView.bounds
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.backgroundColor = AppEffect.dimming
        view.addSubviews(containerView)

        containerView.layer.addSublayer(gradientLayer)

        if let image = volleyballImage {
            maskLayer.contents = image
            maskLayer.contentsGravity = .resizeAspect
            gradientLayer.mask = maskLayer
        }

        gradientLayer.colors = [
            AppColor.Gradient.greenLightStart.cgColor,
            AppColor.Gradient.greenLightEnd.cgColor
        ]

        gradientLayer.shouldRasterize = true
        gradientLayer.rasterizationScale = UIScreen.main.scale
    }

    // MARK: - Animations

    private func startSpin() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 1
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        containerView.layer.add(animation, forKey: "rotation")
    }

    private func stopSpin() {
        containerView.layer.removeAnimation(forKey: "rotation")
    }

    private func animateIn() {
        view.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
        }
    }

    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 44),
            containerView.heightAnchor.constraint(equalToConstant: 44),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
