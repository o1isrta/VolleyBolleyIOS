//
//  LevelInfoViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.07.2025.
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
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = makeLevelsDescription()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(labelDescription)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            contentView.heightAnchor.constraint(equalToConstant: 251),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19.5),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            labelDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labelDescription.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
        
    }
    
    private func makeLevelsDescription() -> NSAttributedString {
        let text = """
            Light: New to the game
            
            Medium: Know rules, still learning
            
            Hard: Skilled, play often, tournaments experience
            
            Pro: Elite level, official championships experience
            """
        let attributed = NSMutableAttributedString(string: text)
        
        attributed.addAttribute(.font, value: AppFont.Hero.regular(size: 16), range: NSRange(location: 0, length: attributed.length))
        attributed.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributed.length))
        
        let levels = ["Light", "Medium", "Hard", "Pro"]
        for level in levels {
            if let range = attributed.string.range(of: "\(level):") {
                let nsRange = NSRange(range, in: attributed.string)
                attributed.addAttribute(.font, value: AppFont.Hero.bold(size: 16), range: nsRange)
            }
        }
        
        return attributed
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
