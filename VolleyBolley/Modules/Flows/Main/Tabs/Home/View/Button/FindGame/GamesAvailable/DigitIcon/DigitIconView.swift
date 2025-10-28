//
//  DigitIconView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import UIKit

final class DigitIconView: UIView {

    // MARK: - Private Properties

    private enum Constants {
        static let contentInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        static let digitSpacing: CGFloat = 0
        /// show plus for numbers greater than this
        static let maxDisplayableNumber: Int = 99
        /// numbers >= this are two-digit
        static let minTwoDigitNumber: Int = 10
        static let digitContentMode: UIView.ContentMode = .scaleAspectFit
    }

    private var digitImageViews: [UIImageView] = []

    private let digitIcons: [UIImage] = [
        .Icon.Digit.digit0,
        .Icon.Digit.digit1,
        .Icon.Digit.digit2,
        .Icon.Digit.digit3,
        .Icon.Digit.digit4,
        .Icon.Digit.digit5,
        .Icon.Digit.digit6,
        .Icon.Digit.digit7,
        .Icon.Digit.digit8,
        .Icon.Digit.digit9
    ]

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        view.spacing = Constants.digitSpacing
        return view
    }()

    private let plusImageView: UIImageView = {
        let view = UIImageView()
        view.image = .plus
        view.tintColor = AppColor.Icon.inverted
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public API

    func configure(with number: Int) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let digits: [Int]
        let showPlus: Bool

        if number > Constants.maxDisplayableNumber {
            digits = [9, 9]
            showPlus = true
        } else if number >= Constants.minTwoDigitNumber {
            digits = String(number).compactMap { Int(String($0)) }
            showPlus = false
        } else {
            digits = [number]
            showPlus = false
        }

        for digit in digits {
            let imageView = UIImageView()
            imageView.contentMode = Constants.digitContentMode
            imageView.image = digitIcons[digit]
            imageView.tintColor = AppColor.Icon.inverted
            stackView.addArrangedSubview(imageView)
        }

        if showPlus {
            plusImageView.isHidden = false
        }
    }

    private func setupView() {
        addSubviews(plusImageView, stackView)

        stackView.pinToSuperviewEdges(insets: Constants.contentInsets)
        setupConstraintsPlusImageView()
    }

    private func setupConstraintsPlusImageView() {
        NSLayoutConstraint.activate([
            plusImageView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ])
    }
}
