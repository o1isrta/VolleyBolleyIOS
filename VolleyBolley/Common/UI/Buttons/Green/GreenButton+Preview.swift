//
//  GreenButton+Preview.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.08.2025.
//

#if DEBUG
import UIKit

/// A view controller for previewing the appearance and interaction of `GreenButton`s in various UI arrangements.
/// 
/// This view controller is intended for use in development and debugging.
/// It displays several horizontal stacks of `GreenButton`
/// instances to demonstrate different configurations,
/// such as game level selection, gender selection, date picking, and player rating
/// actions. Each button toggles its selection state when tapped.
/// The preview can show buttons with or without images and with images
/// positioned in different places (e.g., trailing, top).
///
/// The preview uses the app's background color
/// and arranges the button samples in a vertically stacked layout
///
/// - Note: Only available in DEBUG builds and within the iOS 17.0 or later preview system.
///
final class GreenButtonPreviewVC: UIViewController {

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

        setupLevelRow(in: stack)
        setupGenderRow(in: stack)
        setupDateRow(in: stack)
        setupRatePlayerRow(in: stack)
    }

    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func setupLevelRow(in stack: UIStackView) {
        let row = makeRow(distribution: .fillProportionally)
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(title: "Light", selected: true))
        row.addArrangedSubview(makeButton(title: "Medium", selected: true))
        row.addArrangedSubview(makeButton(title: "Hard", selected: true))
        row.addArrangedSubview(makeButton(title: "Pro"))
    }

    private func setupGenderRow(in stack: UIStackView) {
        let row = makeRow(distribution: .fillProportionally)
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(title: "gender.mix", selected: true))
        row.addArrangedSubview(makeButton(title: "gender.men"))
        row.addArrangedSubview(makeButton(title: "gender.women"))
    }

    private func setupDateRow(in stack: UIStackView) {
        let row = makeRow(distribution: .fillProportionally)
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(title: "Today", selected: true))
        row.addArrangedSubview(makeButton(
            title: "Pick date",
            image: .arrowForward,
            imagePlacement: .trailing
        ))
    }

    private func setupRatePlayerRow(in stack: UIStackView) {
        let row = makeRow(distribution: .fillEqually)
        stack.addArrangedSubview(row)
        row.addArrangedSubview(makeButton(
            title: "Level down",
            image: UIImage.Icon.levelDown,
            imagePlacement: .top
        ))
        row.addArrangedSubview(makeButton(
            title: "Confirm level",
            selected: true,
            image: UIImage.Icon.confirmLevel,
            imagePlacement: .top
        ))
        row.addArrangedSubview(makeButton(
            title: "Level up",
            image: UIImage.Icon.levelUp,
            imagePlacement: .top
        ))
    }

    private func makeRow(distribution: UIStackView.Distribution) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 8
        row.distribution = distribution
        return row
    }

    private func makeButton(
        title: String,
        selected: Bool = false,
        image: UIImage? = nil,
        imagePlacement: NSDirectionalRectEdge? = nil
    ) -> GreenButton {
        let button = GreenButton(imagePlacement: imagePlacement)
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
    GreenButtonPreviewVC()
}

#endif
