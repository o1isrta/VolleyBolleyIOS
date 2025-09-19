//
//  DigitIconView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import UIKit

final class DigitIconView: UIView {

    // MARK: - Private Properties

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

        if number > 99 {
            digits = [9, 9]
            showPlus = true
        } else if number >= 10 {
            digits = String(number).compactMap { Int(String($0)) }
            showPlus = false
        } else {
            digits = [number]
            showPlus = false
        }

        for digit in digits {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
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

        stackView.pinToSuperviewEdges(insets: .init(top: 0, left: 10, bottom: 0, right: 10))
        setupConstraintsPlusImageView()
    }

    private func setupConstraintsPlusImageView() {
        NSLayoutConstraint.activate([
            plusImageView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ])
    }
}
