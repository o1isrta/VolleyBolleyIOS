//
//  GamesAvailableView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

final class GamesAvailableView: UIView {

    // MARK: - Private Properties

    private enum Constants {
        static let stackSpacing: CGFloat = 8
        static let cornerRadius: CGFloat = 28
        static let contentInsets = UIEdgeInsets(top: 9, left: 18, bottom: 9, right: 18)
        static let titleFontSize: CGFloat = 12
    }

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [digitIconView, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.stackSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var digitIconView = DigitIconView()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Hero.bold(size: Constants.titleFontSize)
        label.textColor = AppColor.Text.inverted
        label.text = String(localized: .homeGamesAvailable)
        return label
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with gamesAvailable: Int) {
        digitIconView.configure(with: gamesAvailable)
    }

    private func setupUI() {
        backgroundColor = AppColor.Background.primary
        layer.cornerRadius = Constants.cornerRadius

        addSubview(vStackView)
        vStackView.pinToSuperviewEdges(insets: Constants.contentInsets)
    }
}
