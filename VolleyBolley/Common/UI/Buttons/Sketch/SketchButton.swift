//
//  SketchButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.08.2025.
//

import UIKit

/// A custom-styled `UIButton` subclass that presents a skewed label and an image,
/// supporting a stylized "sketch" appearance with dynamic backgrounds and visual effects.
/// 
/// `SketchButton` manages its own title and image subviews, handling their layout,
/// transformation, and constraints. The button supports different visual states including
/// normal, selected, highlighted, and their combinations, each with configurable styling
/// via associated style objects.
/// 
/// The background effect (such as glassmorphism) and visual appearance is dynamically
/// applied depending on the button state. The button also customizes its intrinsic
/// content size to support a unique design.
/// 
/// - Features:
///   - Skewed (rotated) multiline title label.
///   - Image view anchored to the bottom-right.
///   - Glassmorphism background effect support.
///   - State-based styling (colors, fonts, backgrounds, etc.).
///   - Fully programmatic layout (no storyboards).
///   - Not available via Interface Builder.
/// 
/// Usage:
/// ```swift
/// let button = SketchButton(title: "My Button", image: UIImage(named: "icon"))
/// button.isSelected = true
/// ```
///
/// - Note: This button is designed for a fixed size and may require adaptation for
///   accessibility or dynamic layout requirements.
///   
final class SketchButton: UIButton {

    // MARK: - Private Properties

    private lazy var actionTitleLabel: UILabel = {
        let view = UILabel()
        let angleDegrees: CGFloat = -7.7
        let angleRadians = angleDegrees * (.pi / 180)
        view.transform = CGAffineTransform(rotationAngle: angleRadians)
        view.textAlignment = .left
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var actionImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var activeBackgroundEffect: UIView?

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        setupActionLayout()

        self.configuration = UIButton.Configuration.filled()

        self.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            button.configuration = self.configuration(for: button.state)
        }
    }

    convenience init(
        title: String,
        image: UIImage?,
        isSelected: Bool = false
    ) {
        self.init()

        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        self.isSelected = isSelected
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let style = resolveStyle(for: state)

        if let newEffect = resolveStyle(for: state).backgroundEffectProvider?() as? GlassmorphismView {
            newEffect.frame = bounds
            newEffect.cornerRadius = style.cornerRadius

            if activeBackgroundEffect !== newEffect {
                activeBackgroundEffect?.removeFromSuperview()
                insertSubview(newEffect, at: 0)
                activeBackgroundEffect = newEffect
            }
        } else {
            if let existing = activeBackgroundEffect {
                existing.removeFromSuperview()
                activeBackgroundEffect = nil
            }
        }
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        actionTitleLabel.text = title
    }

    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        actionImageView.image = image
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 175, height: 180)
    }

    // MARK: - Private Methods

    private func configuration(for state: UIControl.State) -> UIButton.Configuration {
        let style = resolveStyle(for: state)
        var config = UIButton.Configuration.filled()

        config.background.backgroundColor = style.backgroundColor
        config.background.cornerRadius = style.cornerRadius

        actionTitleLabel.font = style.font
        actionTitleLabel.textColor = style.titleColor
        actionImageView.tintColor = style.tintColor

        return config
    }

    private func resolveStyle(for state: UIControl.State) -> SketchButtonStyle {
        switch (state.contains(.selected), state.contains(.highlighted)) {
        case (true, true): return SketchButtonStateStyle.highlightedSelected.style
        case (true, false): return SketchButtonStateStyle.selected.style
        case (false, true): return SketchButtonStateStyle.highlightedNormal.style
        default: return SketchButtonStateStyle.normal.style
        }
    }

    // MARK: - Layout

    private func setupActionLayout() {
        addSubview(actionTitleLabel)
        addSubview(actionImageView)

        setupConstraintsActionTitleLabel()
        setupConstraintsActionImageView()
    }

    // MARK: - Constraints

    private func setupConstraintsActionTitleLabel() {
        NSLayoutConstraint.activate([
            actionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            actionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            actionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }

    private func setupConstraintsActionImageView() {
        NSLayoutConstraint.activate([
            actionImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionImageView.heightAnchor.constraint(equalToConstant: 130),
            actionImageView.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
}

// MARK: - Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview() {
    SketchButtonPreviewVC()
}
#endif
