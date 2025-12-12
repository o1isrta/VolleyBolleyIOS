//
//  YellowButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.08.2025.
//

import UIKit

/// A custom UIButton subclass styled with a distinctive yellow theme.
///
/// `YellowButton` provides a reusable button component with consistent appearance,
/// including custom font, colors, borders, and corner radius. The style
/// dynamically responds to different control states such as normal, selected,
/// highlighted, and disabled. All configuration changes are handled via the
/// configuration update handler, ensuring that the button's appearance is always
/// up-to-date with its state.
///
final class YellowButton: UIButton {

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        self.configuration = UIButton.Configuration.plain()

        configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            button.configuration = self.configuration(for: button.state)
        }

		titleLabel?.numberOfLines = 1
		titleLabel?.adjustsFontSizeToFitWidth = true
		titleLabel?.minimumScaleFactor = 0.7
    }

    convenience init(
        title: String,
        isSelected: Bool = false
    ) {
        self.init()

        setTitle(title, for: .normal)
        self.isSelected = isSelected
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Private Methods

    private func configuration(for state: UIControl.State) -> UIButton.Configuration {
        let style = resolveStyle(for: state)

        var config = UIButton.Configuration.plain()

        var attributes = AttributeContainer()
        attributes.font = style.font
        attributes.foregroundColor = style.titleColor

        config.attributedTitle = AttributedString(title(for: state) ?? "", attributes: attributes)
        config.background.backgroundColor = style.backgroundColor
        config.background.strokeColor = style.borderColor
        config.background.cornerRadius = style.cornerRadius
        config.background.strokeWidth = style.borderWidth
        config.contentInsets = style.contentInsets
        config.titleAlignment = .center
		config.titleLineBreakMode = .byTruncatingTail

        return config
    }

    private func resolveStyle(for state: UIControl.State) -> YellowButtonStyle {
        if state.contains(.disabled) {
            return YellowButtonStateStyle.disabled.style
        }

        switch (state.contains(.selected), state.contains(.highlighted)) {
        case (true, true):
            return YellowButtonStateStyle.highlightedSelected.style
        case (true, false):
            return YellowButtonStateStyle.selected.style
        case (false, true):
            return YellowButtonStateStyle.highlightedNormal.style
        default:
            return YellowButtonStateStyle.normal.style
        }
    }
}

// MARK: - Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview() {
    YellowButtonPreviewVC()
}
#endif
