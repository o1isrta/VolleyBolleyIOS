//
//  LevelInfoViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 16.08.2025.
//
import UIKit

class LevelInfoViewController: UIViewController {

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppEffect.BackgroundAlert.alert
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = AppColor.Background.modal
        container.layer.cornerRadius = 32
        container.clipsToBounds = true
        return container
    }()

    private lazy var backButton: UIButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel = CustomTitle(text: String(localized:"About levels"), isLarge: true)
    private lazy var levelsStack = makeLevelRow()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animatePopupAppearance()
        view.backgroundColor = AppEffect.BackgroundAlert.alert
    }

    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(contentView)

        [backButton,
         titleLabel,
         levelsStack].forEach {
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22.5),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 18),
            backButton.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            levelsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            levelsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            levelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            levelsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func makeLevelRow() -> UIStackView {
        let levelsStack = UIStackView()
        levelsStack.axis = .vertical
        levelsStack.alignment = .fill
        levelsStack.spacing = 21.73
        levelsStack.translatesAutoresizingMaskIntoConstraints = false

        let levelTitles = [
            String(localized:"Light:"),
            String(localized:"Medium:"),
            String(localized:"Hard:"), String(localized:"Pro:")
        ]

        let levelDescriptions = [
            String(localized:"New to the game"),
            String(localized:"Know rules, still learning"),
            String(localized:"Skilled, play often, tournaments experience"),
            String(localized:"Elite level, official championships experience")
        ]

        for count in 0..<levelTitles.count {
            let titleLabel = GradientTextLabel()
            titleLabel.gradientColors = [AppColor.Gradient.greenLightStart, AppColor.Gradient.greenLightEnd]
            titleLabel.text = levelTitles[count]
            titleLabel.font = AppFont.Hero.bold(size: 16)
            titleLabel.numberOfLines = 1
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            titleLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true

            let descLabel = UILabel()
            descLabel.text = levelDescriptions[count]
            descLabel.font = AppFont.Hero.regular(size: 16)
            descLabel.textColor = AppColor.Text.primary
            descLabel.numberOfLines = 0
            descLabel.translatesAutoresizingMaskIntoConstraints = false

            let rowStack = UIStackView(arrangedSubviews: [titleLabel, descLabel])
            rowStack.axis = .horizontal
            rowStack.spacing = 12
            rowStack.alignment = .top
            rowStack.translatesAutoresizingMaskIntoConstraints = false

            descLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)

            descLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            descLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

            levelsStack.addArrangedSubview(rowStack)
        }

        return levelsStack
    }

    @objc private func didTapBack() {
        dismiss(animated: true)
    }

    private func animatePopupAppearance() {
        contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        contentView.alpha = 0

        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseOut,
                       animations: {
            self.contentView.transform = .identity
            self.contentView.alpha = 1
        }, completion: nil)
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    LevelInfoViewController()
}
#endif
