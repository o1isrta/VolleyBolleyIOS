//
//  OrangeButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 13.08.2025.
//

import UIKit

/// A custom UIButton subclass that displays an orange-styled button, 
/// applying visual properties (such as background color, corner radius, 
/// and font) defined by `OrangeButtonStyle`.
///
/// You can customize its appearance by passing a different 
/// `OrangeButtonStyle` during initialization.
///
/// Example:
/// ```swift
/// let button = OrangeButton(style: .small)
/// ```
/// 
final class OrangeButton: UIButton {

    // MARK: - Initializers

    init(style: OrangeButtonStyle = .init()) {
        super.init(frame: .zero)
        configuration(style: style)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func configuration(style: OrangeButtonStyle) {
        var config = UIButton.Configuration.filled()
        config.background.cornerRadius = style.cornerRadius
        config.baseForegroundColor = style.titleColor
        config.baseBackgroundColor = style.backgroundColor
        config.contentInsets = style.contentInsets
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { container in
            var newContainer = container
            newContainer.font = style.font
            return newContainer
        }
        configuration = config
    }
}

// MARK: - Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview() {
    OrangeButtonPreviewVC()
}
#endif
