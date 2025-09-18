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

enum SketchButtonType: CaseIterable {
    case createTourney
    case donate
    case invitePlayers
    case shareLink
    case sendInvites
    case saveGame

    var title: String {
        switch self {
        case .createTourney: return "Create a tourney"
        case .donate: return "Donate"
        case .invitePlayers: return "Invite players"
        case .shareLink: return "Share link"
        case .sendInvites: return "Send invites"
        case .saveGame: return "Save game"
        }
    }

    var image: UIImage? {
        switch self {
        case .createTourney: return UIImage.Icon.createTourney
        case .donate: return UIImage.Icon.donate
        case .invitePlayers: return UIImage.Icon.invitePlayers
        case .shareLink: return UIImage.Icon.share
        case .sendInvites: return UIImage.Icon.sendInvites
        case .saveGame: return UIImage.Icon.saveGame
        }
    }
}

private struct ImageLayout {
    let widthMultiplier: CGFloat
    let heightMultiplier: CGFloat
    let trailingOffset: CGFloat
    let bottomOffset: CGFloat
}

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
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var activeBackgroundEffect: UIView?
    private let type: SketchButtonType

    // MARK: - Initializers

    init(type: SketchButtonType, isSelected: Bool = false) {
        self.type = type
        super.init(frame: .zero)

        clipsToBounds = true

        setupActionLayout()

        setTitle(type.title, for: .normal)
        setImage(type.image, for: .normal)
        self.isSelected = isSelected

        self.configuration = UIButton.Configuration.filled()

        self.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            button.configuration = self.configuration(for: button.state)
        }
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

    private func attributedTitle(
        title: String,
        color: UIColor,
        font: UIFont
    ) -> AttributedString {
        var attributes = AttributeContainer()
        attributes.foregroundColor = color
        attributes.font = font
        return AttributedString(title, attributes: attributes)
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
        let layout = type.imageLayout

        NSLayoutConstraint.activate([
            actionImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: layout.widthMultiplier),
            actionImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: layout.heightMultiplier),
            actionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: layout.trailingOffset),
            actionImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: layout.bottomOffset)
        ])
    }
}

private extension SketchButtonType {
    var imageLayout: ImageLayout {
        switch self {
        case .createTourney:
            return .init(widthMultiplier: 1, heightMultiplier: 1, trailingOffset: 30, bottomOffset: 30)
        case .donate:
            return .init(widthMultiplier: 0.75, heightMultiplier: 0.75, trailingOffset: 10, bottomOffset: -10)
        case .invitePlayers:
            return .init(widthMultiplier: 0.9, heightMultiplier: 0.76, trailingOffset: 28, bottomOffset: 20)
        case .shareLink:
            return .init(widthMultiplier: 0.63, heightMultiplier: 0.5, trailingOffset: -26, bottomOffset: -28)
        case .sendInvites:
            return .init(widthMultiplier: 0.75, heightMultiplier: 0.5, trailingOffset: -7, bottomOffset: -7)
        case .saveGame:
            return .init(widthMultiplier: 0.6, heightMultiplier: 0.6, trailingOffset: -22, bottomOffset: 8)
        }
    }
}

// MARK: - Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview() {
    SketchButtonPreviewVC()
}
#endif
