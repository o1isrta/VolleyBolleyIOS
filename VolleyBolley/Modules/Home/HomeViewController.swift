//
//  HomeViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showGreeting(_ message: String)
}

final class HomeViewController: BaseViewController, HomeViewProtocol {

    // MARK: - Private Properties

    private let presenter: HomePresenterProtocol

    let button = AppButtonView(config: AppButtonPrimary.save)

    // MARK: - Initializers

    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        setupUI()

    }

    // MARK: - Public Methods

    func showGreeting(_ message: String) {
//        let label = UILabel()
//        label.text = message
//        label.textAlignment = .center
//        label.font = AppFont.Quantex.regular(size: 16)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(label)

//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.addSubview(button)
        button.setVisualState(.selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
