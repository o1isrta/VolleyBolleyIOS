//
//  SketchButton+Preview.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.08.2025.
//

#if DEBUG
import UIKit

/// A view controller that previews various configurations
/// of the custom `SketchButton` for development and testing.
///
/// The preview demonstrates the appearance of `SketchButton`
/// instances in different states,
/// as well as layout combinations within stack views. It uses
/// a main app background color and organized vertical stacks to
/// display several button variants for visual review.
///
/// - Note: This class is only available in DEBUG builds and is intended
/// for use with Xcode Previews or for in-app development previews.
///
final class SketchButtonPreviewVC: UIViewController {

    override func loadView() {
        let container = UIView()
        container.backgroundColor = AppColor.Background.screen
        self.view = container

        let stack = makeStackView()
        container.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 70),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8)
        ])

        setupFirstRow(in: stack)
        setupSecondRow(in: stack)
        setupThirdRow(in: stack)
    }

    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func setupFirstRow(in stack: UIStackView) {
        let row = makeRow()
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(
            title: "Create a tourney",
            image: UIImage.Icon.createTourney,
            selected: true
        ))
        row.addArrangedSubview(makeButton(
            title: "Donate",
            image: UIImage.Icon.donate
        ))
    }

    private func setupSecondRow(in stack: UIStackView) {
        let row = makeRow()
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(
            title: "Invite players",
            image: UIImage.Icon.invitePlayers,
            selected: true
        ))
        row.addArrangedSubview(makeButton(
            title: "Share link",
            image: UIImage.Icon.share
        ))
    }

    private func setupThirdRow(in stack: UIStackView) {
        let row = makeRow()
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(
            title: "Send invites",
            image: UIImage.Icon.sendInvites,
            selected: true
        ))
        row.addArrangedSubview(makeButton(
            title: "Save game",
            image: UIImage.Icon.saveGame
        ))
    }

    private func makeRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 8
        row.distribution = .fillProportionally
        return row
    }

    private func makeButton(
        title: String,
        image: UIImage? = nil,
        selected: Bool = false,
    ) -> SketchButton {
        let button = SketchButton()
        button.isSelected = selected
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.addAction(UIAction { _ in
            button.isSelected.toggle()
        }, for: .touchUpInside)
        return button
    }
}

@available(iOS 17.0, *)
#Preview() {
    SketchButtonPreviewVC()
}

#endif
