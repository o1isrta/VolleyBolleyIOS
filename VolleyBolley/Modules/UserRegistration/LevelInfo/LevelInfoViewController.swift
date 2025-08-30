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
        container.backgroundColor = AppColor.Background.screen
        container.layer.cornerRadius = 32
        return container
    }()

    private lazy var blurEffectView: UIVisualEffectView = {
           let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
           let effectView = UIVisualEffectView(effect: blurEffect)
           effectView.translatesAutoresizingMaskIntoConstraints = false
           return effectView
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
        setupUI()
        animatePopupAppearance()
    }

    private func setupUI() {
        view.addSubview(contentView)
        contentView.addSubview(blurEffectView)

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
            
            blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

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

    private func makeLevelRow() -> UIStackView {
        // Создаем стек для названий уровней с зеленым цветом
        let levelsStack = UIStackView()
        levelsStack.axis = .vertical
        levelsStack.alignment = .leading
        levelsStack.spacing = 12
        
        let levelTitles = [
            "Light:",
            "Medium:",
            "Hard:",
            "Pro:"
        ]
        
        let levelDescriptions = [
            "New to the game",
            "Know rules, still learning",
            "Skilled, play often, tournaments experience",
            "Elite level, official championships experience"
        ]
        
        // Создаем label для каждого уровня
        for count in 0..<levelTitles.count {
            let levelContainer = UIStackView()
            levelContainer.axis = .horizontal
            levelContainer.alignment = .top
            levelContainer.spacing = 8
            
            // Название уровня - зеленый цвет
            let titleLabel = GradientTextLabel()
            titleLabel.text = levelTitles[count]
            titleLabel.font = AppFont.Hero.bold(size: 16) // Жирный шрифт для выделения
            titleLabel.gradientColors = [
                AppColor.Gradient.greenLightStart,
                AppColor.Gradient.greenLightEnd
            ]
            
            // Описание уровня
            let descLabel = UILabel()
            descLabel.text = levelDescriptions[count]
            descLabel.font = AppFont.Hero.regular(size: 16)
            descLabel.textColor = AppColor.Text.primary
            descLabel.numberOfLines = 0
            
            levelContainer.addArrangedSubview(titleLabel)
            levelContainer.addArrangedSubview(descLabel)
            levelsStack.addArrangedSubview(levelContainer)
        }
        
        levelsStack.translatesAutoresizingMaskIntoConstraints = false
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


