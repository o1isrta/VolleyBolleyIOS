//
//  LevelInfoViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 16.08.2025.
//
import UIKit

class LevelInfoViewController: UIViewController {

    private lazy var contentView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = AppColor.Background.blur
        container.layer.cornerRadius = 32
        return container
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel = CustomTitle(text: "About levels", isLarge: true)

    private lazy var levelsStack = makeLevelRow()

    override func viewDidLoad() {
        super.viewDidLoad()
                view.backgroundColor = AppColor.Background.screen
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupUI()
        animatePopupAppearance()
    }

    private func setupUI() {
        view.addSubview(contentView)

        [backButton,
         titleLabel,
         levelsStack].forEach {
            contentView.addSubview($0)
        }

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 38),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentView.heightAnchor.constraint(equalToConstant: 251),

            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19.5),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            levelsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            levelsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            levelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            levelsStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Создание уровней
    private func makeLevelRow() -> UIStackView {
        let gradientNames = GradientLabel(
            names: ["Light:", "Medium:", "Hard:", "Pro:"],
            gradientColors: [UIColor.systemYellow, UIColor.systemGreen]
        )

        let descStack = UIStackView()
            descStack.axis = .vertical
            descStack.alignment = .leading
            descStack.spacing = 12

            [
                "New to the game",
                "Know rules, still learning",
                "Skilled, play often, tournaments experience",
                "Elite level, official championships experience"
            ].forEach { text in
                let label = UILabel()
                label.text = text
                label.font = AppFont.Hero.regular(size: 16)
                label.textColor = AppColor.Text.primary
                label.numberOfLines = 0
                descStack.addArrangedSubview(label)
            }

            let container = UIStackView(arrangedSubviews: [gradientNames, descStack])
            container.axis = .horizontal
            container.alignment = .top
            container.spacing = 8
            container.translatesAutoresizingMaskIntoConstraints = false

            return container
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


