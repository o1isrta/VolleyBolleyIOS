//
//  AppButtonSecondary.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

// TODO: - Temp view. Refactor or delete

/// View with blur effect
final class GlassEffectView: UIView {

    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }

    private let blurView: UIVisualEffectView

    init(effect: UIVisualEffect? = UIBlurEffect(style: .systemUltraThinMaterialLight)) {
        self.blurView = UIVisualEffectView(effect: effect)
        super.init(frame: .zero)

        isUserInteractionEnabled = false
        clipsToBounds = true

        blurView.alpha = 0.5
        blurView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurView)

        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
