//
//  GamesAvailableView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

final class GamesAvailableView: UIView {

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [digitIconView, gamesAvailableLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var digitIconView = DigitIconView()

    private lazy var gamesAvailableLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Hero.bold(size: 12)
        label.textColor = AppColor.Text.inverted
        label.text = String(localized: "home.gamesAvailable")
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
        layer.cornerRadius = 28

        addSubview(vStackView)
        vStackView.pinToSuperviewEdges()
    }
}
