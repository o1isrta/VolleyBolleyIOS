//
//  OrangeButton+Preview.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.08.2025.
//

#if DEBUG
import UIKit

/// A view controller that previews various configurations
/// of the custom `OrangeButton` for development and testing.
///
/// The preview demonstrates the appearance of `OrangeButton`
/// instances in different states,
/// as well as layout combinations within stack views. It uses
/// a main app background color and organized vertical stacks to
/// display several button variants for visual review.
///
/// - Note: This class is only available in DEBUG builds and is intended
/// for use with Xcode Previews or for in-app development previews.
///
final class OrangeButtonPreviewVC: UIViewController {

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

        setupButtonStack(in: stack)
    }

    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func setupButtonStack(in stack: UIStackView) {
        let row = makeStack(distribution: .fillProportionally)
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(title: "Map"))
        row.addArrangedSubview(makeButton(title: "Map", style: .small))
    }

    private func makeStack(distribution: UIStackView.Distribution) -> UIStackView {
        let row = UIStackView()
        row.axis = .vertical
        row.spacing = 8
        row.distribution = distribution
        row.alignment = .center
        return row
    }

    private func makeButton(
        title: String,
        style: OrangeButtonStyle = .init()
    ) -> OrangeButton {
        let button = OrangeButton(style: style)
        button.setTitle(title, for: .normal)
        return button
    }
}

@available(iOS 17.0, *)
#Preview() {
    OrangeButtonPreviewVC()
}

#endif
