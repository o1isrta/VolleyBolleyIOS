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
        static let badgeSize: CGFloat = 132
        static let badgeBorder: CGFloat = 2
        static let badgeFontSize: CGFloat = 22
    }
    
    // MARK: - Private Properties
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Quantex.regular(size: Constants.badgeFontSize)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    init(_ level: UserLevel) {
        super.init(frame: .zero)
        setupView()
        configure(with: level)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: Constants.badgeSize, height: Constants.badgeSize)
    }
}

// MARK: - Private Methods

private extension LevelBadgeView {
    
    func configure(with level: UserLevel) {
        levelLabel.text = level.title
        levelLabel.textColor = level.titleColor
        backgroundColor = level.color
        
        layer.cornerRadius = Constants.badgeSize / 2
        layer.masksToBounds = true
        layer.borderWidth = Constants.badgeBorder
        layer.borderColor = AppColor.Border.primary.cgColor
    }
    
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
        
        VStack(spacing: 12) {
            ForEach(UserLevel.allCases, id: \.self) { level in
                UIViewPreview {
                    LevelBadgeView(level)
                }
                .frame(width: 132, height: 132)
            }
        }
        .padding()
    }
}
#endif
