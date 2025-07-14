//
//  CustomTabBarView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 14.07.2025.
//

import UIKit

protocol CustomTabBarViewDelegate: AnyObject {
    /// Called when a tab item is selected.
    func customTabBarView(_ tabBarView: CustomTabBarView, didSelectItemAt index: Int)
}

final class CustomTabBarView: UIView {

    // MARK: - Public Properties

    /// Delegate to notify about tab selection changes.
    weak var delegate: CustomTabBarViewDelegate?

    // MARK: - Private Properties

    private var didInitialLayout = false
    private var items: [TabBarItem] = []
    private var selectedIndex: Int = 0

    private enum UIConstants {
        static let tabBarCornerRadius: CGFloat = 32
        static let tabBarHeight: CGFloat = 60
        static let iconSize: CGFloat = 24
        static let labelFontSize: CGFloat = 10
        static let stackSpacing: CGFloat = 4
    }

    // MARK: - UI Components

    private var buttons: [UIButton] = []

    private lazy var tabBarStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private enum TabBarUI {
        static func label(text: String) -> UILabel {
            let view = UILabel()
            view.text = text
            view.font = AppFont.Hero.regular(size: UIConstants.labelFontSize)
            view.textAlignment = .center
            view.textColor = AppColor.Text.primary
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }

        static func imageView(image: UIImage?) -> UIImageView {
            let view = UIImageView(image: image)
            view.tintColor = AppColor.Text.primary
            view.contentMode = .scaleAspectFit
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }

        static func tabContentStack(icon: UIImageView, label: UILabel) -> UIStackView {
            let view = UIStackView(arrangedSubviews: [icon, label])
            view.axis = .vertical
            view.alignment = .center
            view.spacing = UIConstants.stackSpacing
            view.isUserInteractionEnabled = false
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }

        static func button(index: Int, target: Any?, action: Selector) -> UIButton {
            let button = UIButton(type: .custom)
            button.tag = index
            button.addTarget(target, action: action, for: .touchUpInside)
            button.imageView?.contentMode = .center
            return button
        }
    }

    // MARK: - Initializers

    init(items: [TabBarItem]) {
        super.init(frame: .zero)

        self.items = items

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !didInitialLayout {
            configureButton(at: selectedIndex, isSelected: true)
            didInitialLayout = true
        }
    }

    // MARK: - Public Methods

    func updateSelection(index: Int) {
        guard index != selectedIndex else { return }

        configureButton(at: selectedIndex, isSelected: false)
        configureButton(at: index, isSelected: true)
        selectedIndex = index
    }

    private func configureButton(at index: Int, isSelected: Bool) {
        let button = buttons[index]

        guard
            buttons.indices.contains(index),
            let stack = button.subviews.first(where: { $0 is UIStackView }) as? UIStackView,
            let label = stack.arrangedSubviews.compactMap({ $0 as? UILabel }).first,
            let imageView = stack.arrangedSubviews.compactMap({ $0 as? UIImageView }).first
        else {
            return
        }

        let item = items[index]
        label.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        imageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        label.text = item.title
        imageView.image = item.icon

        if isSelected {
            label.textColor = .clear
            label.layoutIfNeeded()
            imageView.layoutIfNeeded()
                let gradient = CALayer.makeGradientTextMask(for: label)
                label.layer.addSublayer(gradient)

                let size = imageView.bounds.size == .zero
                    ? CGSize(width: UIConstants.iconSize, height: UIConstants.iconSize)
                    : imageView.bounds.size

            let iconGradient = CALayer.makeGradientIconMask(image: item.icon, size: size)
                imageView.image = nil
                imageView.layer.addSublayer(iconGradient)
        } else {
            label.textColor = AppColor.Text.primary
        }
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColor = AppColor.Background.tabBar
        layer.cornerRadius = UIConstants.tabBarCornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true

        setupButtons()
    }

    private func setupButtons() {
        for (index, item) in items.enumerated() {
            let button = createTabButton(
                title: item.title,
                image: item.icon,
                index: index
            )
            buttons.append(button)
            tabBarStackView.addArrangedSubview(button)
            configureButton(at: index, isSelected: index == 0)
        }
    }

    private func createTabButton(
        title: String,
        image: UIImage?,
        index: Int
    ) -> UIButton {
        let button = TabBarUI.button(index: index, target: self, action: #selector(tabButtonTapped(_:)))
        let iconImageView = TabBarUI.imageView(image: image)
        let titleLabel = TabBarUI.label(text: title)
        let stack = TabBarUI.tabContentStack(icon: iconImageView, label: titleLabel)

        button.addSubview(stack)
        setupConstraintsTabContentStackView(button: button, stack: stack)
        setupConstraintsImageView(imageView: iconImageView)

        return button
    }

    // MARK: - Actions

    @objc private func tabButtonTapped(_ sender: UIButton) {
        updateSelection(index: sender.tag)
        delegate?.customTabBarView(self, didSelectItemAt: sender.tag)
    }

    // MARK: - Layout

    private func setupLayout() {
        addSubview(tabBarStackView)
        setupConstraintsTabBarStackView()
    }

    // MARK: - Constraints

    private func setupConstraintsTabBarStackView() {
        NSLayoutConstraint.activate([
            tabBarStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabBarStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabBarStackView.topAnchor.constraint(equalTo: topAnchor),
            tabBarStackView.heightAnchor.constraint(equalToConstant: UIConstants.tabBarHeight)
        ])
    }

    private func setupConstraintsTabContentStackView(button: UIButton, stack: UIStackView) {
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
    }

    private func setupConstraintsImageView(imageView: UIImageView) {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: UIConstants.iconSize),
            imageView.heightAnchor.constraint(equalToConstant: UIConstants.iconSize)
        ])
    }
}
