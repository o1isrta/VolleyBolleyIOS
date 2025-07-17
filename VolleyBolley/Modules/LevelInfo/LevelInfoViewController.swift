//
//  LevelInfoViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.07.2025.
//

import UIKit

class LevelInfoViewController: UIViewController {
    
    private let contentView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = AppColor.Background.blur
        container.layer.cornerRadius = 32
        return container
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(LevelInfoViewController.self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel = CustomTitle(text: "About levels", isLarge: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            contentView.heightAnchor.constraint(equalToConstant: 251),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19.5),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
    }
    
    @objc private func didTapBack() {
//        self.dismiss(animated: true, completion: nil)
    }
}

