//
//  LevelInfoViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 16.08.2025.
//
import UIKit

final class LevelInfoViewController: UIViewController {

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

    private lazy var backButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel = CustomTitle(text: String(localized: "About levels"), isLarge: true)
    private lazy var levelsStack = makeLevelRow()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animatePopupAppearance()
        view.backgroundColor = AppEffect.BackgroundAlert.alert
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for case let rowStack as UIStackView in levelsStack.arrangedSubviews {
            if let titleLabel = rowStack.arrangedSubviews.first as? UILabel {
                titleLabel.applyGradient(
                    colors: [AppColor.Gradient.greenLightStart,
                             AppColor.Gradient.greenLightEnd]
                )
            }
        }
    }

    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(contentView)

        [backButton,
         titleLabel,
         levelsStack]
            .forEach {
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

            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
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
            String(localized: "Light:"),
            String(localized: "Medium:"),
            String(localized: "Hard:"),
            String(localized: "Pro:")
        ]

        let levelDescriptions = [
            String(localized: "New to the game"),
            String(localized: "Know rules, still learning"),
            String(localized: "Skilled, play often, tournaments experience"),
            String(localized: "Elite level, official championships experience")
        ]

        for levelCount in 0..<levelTitles.count {
            let titleLabel = UILabel()
            titleLabel.text = levelTitles[levelCount]
            titleLabel.font = AppFont.Hero.bold(size: 16)
            titleLabel.numberOfLines = 1
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            titleLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true

            let descriptionLabel = UILabel()
            descriptionLabel.text = levelDescriptions[levelCount]
            descriptionLabel.font = AppFont.Hero.regular(size: 16)
            descriptionLabel.textColor = AppColor.Text.primary
            descriptionLabel.numberOfLines = 0
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

            let rowStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
            rowStack.axis = .horizontal
            rowStack.spacing = 12
            rowStack.alignment = .top
            rowStack.translatesAutoresizingMaskIntoConstraints = false

            descriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)

            descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

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
