//
//  UtilityButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.08.2025.
//

import UIKit

/// A customizable button subclass that uses a specified style for configuration.
///
/// The `UtilityButton` is a subclass of `UIButton` that allows you to easily apply a consistent
/// style to buttons throughout your app using the `UtilityButtonStyle` type.
/// It provides a convenient initializer for setting the style, and it applies
/// symbol image configurations as specified.
///
/// - Note: Initialization from Interface Builder is unavailable for this class.
///
/// Example usage:
/// ```swift
/// let button = UtilityButton(style: .myCustomStyle)
/// ```
/// 
final class UtilityButton: UIButton {

    // MARK: - Initializers

    init(style: UtilityButtonStyle = .init()) {
        super.init(frame: .zero)
        configuration(style: style)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func configuration(style: UtilityButtonStyle) {
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = style.imageConfig
        configuration = config
    }
}

// MARK: - Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview() {
    UtilityButtonPreviewVC()
}
#endif
