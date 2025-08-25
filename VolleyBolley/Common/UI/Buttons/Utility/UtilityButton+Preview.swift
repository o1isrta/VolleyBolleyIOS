//
//  UtilityButton+Preview.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.08.2025.
//

#if DEBUG
import UIKit

/// A view controller that previews various configurations
/// of the custom `UtilityButton` for development and testing.
///
/// The preview demonstrates the appearance of `UtilityButton`
/// instances in different states,
/// as well as layout combinations within stack views. It uses
/// a main app background color and organized vertical stacks to
/// display several button variants for visual review.
///
/// - Note: This class is only available in DEBUG builds and is intended
/// for use with Xcode Previews or for in-app development previews.
///
final class UtilityButtonPreviewVC: UIViewController {

    override func loadView() {
        let container = UIView()
        container.backgroundColor = AppColor.Background.screen
        self.view = container

        let stack = makeStackView()
        container.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 200),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])

        setupFirstButtonRow(in: stack)
        setupSecondButtonRow(in: stack)
        setupThirdButtonRow(in: stack)
    }

    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func setupFirstButtonRow(in stack: UIStackView) {
        let row = makeRow(distribution: .fillProportionally)

        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(image: .chevronBackward))
        row.addArrangedSubview(makeButton(style: .small, image: .plus))
        row.addArrangedSubview(makeButton(style: .small, image: .minus))
    }

    private func setupSecondButtonRow(in stack: UIStackView) {
        let row = makeRow(distribution: .fillProportionally)
        row.backgroundColor = .white
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(
            image: .chevronBackward,
            tintColor: AppColor.Icon.inverted
        ))
        row.addArrangedSubview(makeButton(
            style: .small,
            image: .plus,
            tintColor: AppColor.Icon.inverted
        ))
        row.addArrangedSubview(makeButton(
            style: .small,
            image: .minus,
            tintColor: AppColor.Icon.inverted
        ))
    }

    private func setupThirdButtonRow(in stack: UIStackView) {
        let row = makeRow(distribution: .fillProportionally)

        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(image: .bell))
        row.addArrangedSubview(makeButton(image: .bellBadge))

        let bellBadgeActiveButton = makeButton(image: .bellBadge)
        if let baseConfig = bellBadgeActiveButton.configuration?.preferredSymbolConfigurationForImage {
            let normalConfig = baseConfig.applying(
                UIImage.SymbolConfiguration(paletteColors: [AppColor.Icon.bellBadge, .white])
            )

            let highlightedConfig = baseConfig.applying(
                UIImage.SymbolConfiguration(paletteColors: [
                    AppColor.Icon.bellBadge.withAlphaComponent(0.7),
                    .white.withAlphaComponent(0.7)
                ])
            )

            bellBadgeActiveButton.setPreferredSymbolConfiguration(normalConfig, forImageIn: .normal)
            bellBadgeActiveButton.setPreferredSymbolConfiguration(highlightedConfig, forImageIn: .highlighted)
        }
        row.addArrangedSubview(bellBadgeActiveButton)
    }

    private func makeRow(distribution: UIStackView.Distribution) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 8
        row.distribution = distribution
        row.alignment = .center
        return row
    }

    private func makeButton(
        style: UtilityButtonStyle = .init(),
        image: UIImage?,
        tintColor: UIColor = AppColor.Icon.primary
    ) -> UtilityButton {
        let button = UtilityButton(style: style)
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        return button
    }
}

@available(iOS 17.0, *)
#Preview() {
    UtilityButtonPreviewVC()
}

#endif
