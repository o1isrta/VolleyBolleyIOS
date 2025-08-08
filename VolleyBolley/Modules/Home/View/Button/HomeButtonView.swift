//
//  HomeButtonView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

enum HomeButtonConfig {
    case createNewGame
    case findGame

    var title: String {
        switch self {
        case .createNewGame: return String(localized: "common.createNewGame")
        case .findGame: return String(localized: "home.findGame")
        }
    }

    var gamesAvailableTitle: String? {
        switch self {
        case .findGame: return String(localized: "home.gamesAvailable")
        default : return nil
        }
    }

    //    var actionImage: UIImage? {
//        switch self {
//        case .createTourney: return UIImage.Icon.createTourney
//        case .invitePlayers: return UIImage.Icon.invitePlayers
//        case .sendInvites: return UIImage.Icon.sendInvites
//        case .saveGame: return UIImage.Icon.saveGame
//        case .donate: return UIImage.Icon.donate
//        case .shareLink: return UIImage.Icon.share
//        }
//    }
}

class BaseHomeButtonView: UIButton {

    // MARK: - Private Properties

    private let styleConfig: HomeButtonConfig
    private var onTap: ((BaseHomeButtonView) -> Void)?

    private var currentCornerRadius: CGFloat = 0

    private struct VisualState {
        let backgroundColor: UIColor
        let textColor: UIColor
        let font: UIFont
        let cornerRadius: CGFloat
        let borderWidth: CGFloat
        let borderColor: UIColor
        let tintColor: UIColor
        let gradientBackgroundColors: [UIColor]
        let gradientBorderColors: [UIColor]
        let backgroundEffect: UIView?
    }

    // MARK: - Subviews

    private let activeBackgroundEffect = GlassEffectView()

    private lazy var homeTitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var courtTitleView: CourtTitleView = {
        let view = CourtTitleView(type: .icon)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var homeButtonSubTitleLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.Hero.regular(size: 16)
        view.text = String(localized: "home.nearYou")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var arrowImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage.Icon.zigzagArrow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    init(_ config: HomeButtonConfig) {
        self.styleConfig = config
        super.init(frame: .zero)

        let config = UIButton.Configuration.plain()
        self.configuration = config

        self.configurationUpdateHandler = { [weak self] button in
            button.configuration = self?.makeConfiguration(for: button.state)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        if let newEffect = visualState(for: state)?.backgroundEffect as? GlassEffectView {
//            newEffect.frame = bounds
//            newEffect.cornerRadius = currentCornerRadius
//
//            if activeBackgroundEffect !== newEffect {
//                activeBackgroundEffect?.removeFromSuperview()
//                insertSubview(newEffect, at: 0)
//                activeBackgroundEffect = newEffect
//            }
//        } else {
//            if let existing = activeBackgroundEffect {
//                existing.removeFromSuperview()
//                activeBackgroundEffect = nil
//            }
//        }
    }

    // MARK: - Public Methods

    func configure(with viewModel: HomeButtonViewModel) {

    }

    func setAction(_ action: @escaping (BaseHomeButtonView) -> Void) {
        removeTarget(self, action: #selector(didTap), for: .touchUpInside)
        onTap = action
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    // MARK: - Private Methods

    private func setupView() {

    }

    private func makeConfiguration(for state: UIControl.State) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()

//        guard let visualState = visualState(for: state) else {
//            return config
//        }
//
//        config.baseBackgroundColor = .clear
//        config.background.cornerRadius = 32
//
////        homeTitleLabel.text = styleConfig.actionTitle
//        homeTitleLabel.font = visualState.font
//        homeTitleLabel.textColor = visualState.textColor
//
//        arrowImageView.image = styleConfig.actionImage
//        arrowImageView.tintColor = visualState.tintColor
//
//        currentCornerRadius = visualState.cornerRadius

//        if styleConfig.actionTitle != nil,
//           styleConfig.actionImage != nil,
//           !hasSetupActionLayout {
//
//            setupLayout()
//            hasSetupActionLayout = true
//        }

//        self.tintColor = visualState.tintColor

        return config
    }

    private func attributedTitle(
        title: String,
        color: UIColor,
        font: UIFont
    ) -> AttributedString {
        var attributes = AttributeContainer()
        attributes.foregroundColor = color
        attributes.font = font
        return AttributedString(title, attributes: attributes)
    }

//    private func visualState(for state: UIControl.State) -> VisualState? {
//        guard let style = styleConfig.style(for: state) else {
//            return nil
//        }
//
//        return VisualState(
//            backgroundColor: style.backgroundColor,
//            textColor: style.titleColor,
//            font: style.font,
//            cornerRadius: style.cornerRadius,
//            borderWidth: style.borderWidth,
//            borderColor: style.borderColor,
//            tintColor: style.tintColor,
//            gradientBackgroundColors: style.gradientBackgroundColors,
//            gradientBorderColors: style.gradientBorderColors,
//            backgroundEffect: style.backgroundEffectProvider?()
//        )
//    }

    // MARK: - Actions

    @objc
    private func didTap() {
        onTap?(self)
    }

    // MARK: - Layout

    private func setupLayout() {
        addSubview(activeBackgroundEffect)

        addSubview(homeTitleLabel)
        addSubview(arrowImageView)

        activeBackgroundEffect.pinToSuperviewEdges()

        setupConstraintsActionTitleLabel()
        setupConstraintsActionImageView()
    }

    // MARK: - Constraints

    private func setupConstraintsActionTitleLabel() {
        NSLayoutConstraint.activate([
            homeTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            homeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            homeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }

    private func setupConstraintsActionImageView() {
        NSLayoutConstraint.activate([
            arrowImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 130),
            arrowImageView.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
}
