//
//  DigitIconView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import UIKit

final class DigitIconView: UIView {

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

    private let plusIcon = UIImage.Icon.invitePlayers

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()

    private var digitImageViews: [UIImageView] = []

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(stackView)
        stackView.pinToSuperviewEdges()
    }

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
            stackView.addArrangedSubview(imageView)
        }

        if showPlus {
            let plusImageView = UIImageView()
            plusImageView.contentMode = .scaleAspectFit
            plusImageView.image = plusIcon
            stackView.addArrangedSubview(plusImageView)
        }
    }
}
