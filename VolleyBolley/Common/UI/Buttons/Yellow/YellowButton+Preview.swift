//
//  YellowButton+Preview.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.08.2025.
//

#if DEBUG
import UIKit

/// A view controller that previews various configurations
/// of the custom `YellowButton` for development and testing.
///
/// This class is only available in DEBUG builds and is intended
/// for use with Xcode Previews or for in-app development previews.
/// 
/// The preview demonstrates the appearance of `YellowButton`
/// instances in different states (selected, enabled, etc.),
/// as well as layout combinations within stack views. It uses
/// a neutral background color and organized vertical stacks to
/// display several button variants for visual review.
///
final class YellowButtonPreviewVC: UIViewController {

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

        setupFirstRow(in: stack)
        setupSecondRow(in: stack)
    }

    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func setupFirstRow(in stack: UIStackView) {
        let row = makeStack(distribution: .fillEqually)
        row.axis = .vertical
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(title: "DONE", selected: true))
        row.addArrangedSubview(makeButton(title: "DONE"))
        row.addArrangedSubview(makeButton(title: "DONE", enabled: false))
    }

    private func setupSecondRow(in stack: UIStackView) {
        let row = makeStack(distribution: .fill)
        stack.addArrangedSubview(row)
        let detailsButton = makeButton(title: "DETAILS", selected: true)
        detailsButton.widthAnchor.constraint(equalToConstant: 202).isActive = true
        row.addArrangedSubview(detailsButton)
        row.addArrangedSubview(makeButton(title: "DECLINE"))
    }

    private func makeStack(distribution: UIStackView.Distribution) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 8
        row.distribution = distribution
        return row
    }

    private func makeButton(
        title: String,
        selected: Bool = false,
        enabled: Bool = true,
        image: UIImage? = nil,
        imagePlacement: NSDirectionalRectEdge? = nil
    ) -> YellowButton {
        let button = YellowButton()
        button.isSelected = selected
        button.isEnabled = enabled
        button.setTitle(title, for: .normal)
        button.addAction(UIAction { _ in
            button.isSelected.toggle()
        }, for: .touchUpInside)
        return button
    }
}

@available(iOS 17.0, *)
#Preview() {
    YellowButtonPreviewVC()
}

#endif
