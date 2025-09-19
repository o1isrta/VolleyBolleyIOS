//
//  LevelBadgeView.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 22.08.2025.
//

import UIKit

final class LevelBadgeView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let badgeSize: CGFloat = 46
        static let badgeBorder: CGFloat = 1
        static let badgeFontSize: CGFloat = 8
    }

    // MARK: - Private Properties

    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Quantex.regular(size: Constants.badgeFontSize)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        configure(with: .unknown)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: Constants.badgeSize, height: Constants.badgeSize)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }

    // MARK: - Public Methods

    func configure(with level: PlayerLevel) {
        levelLabel.text = level.title
        levelLabel.textColor = level.titleColor
        backgroundColor = level.color

        layer.borderWidth = Constants.badgeBorder
        layer.borderColor = AppColor.Border.primary.cgColor
    }
}

// MARK: - Private Methods

private extension LevelBadgeView {

    func setupView() {
        addSubviews(levelLabel)

        NSLayoutConstraint.activate([
            levelLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            levelLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            levelLabel.topAnchor.constraint(equalTo: topAnchor),
            levelLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
    ZStack {
        Color(AppColor.Background.screen).ignoresSafeArea()

        HStack(spacing: 12) {
            ForEach(PlayerLevel.allCases, id: \.self) { level in
                UIViewPreview {
                    let view = LevelBadgeView()
                    view.configure(with: level)
                    return view
                }
                .frame(width: 46, height: 46)
            }
        }
        .padding()
    }
}
#endif
