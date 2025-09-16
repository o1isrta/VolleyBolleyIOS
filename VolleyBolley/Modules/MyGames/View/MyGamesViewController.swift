//
//  MyGamesViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

protocol MyGamesViewProtocol: AnyObject {
    func showGreeting(_ message: String)
    func displayError(message: String)
}

final class MyGamesViewController: BaseViewController, MyGamesViewProtocol {

    // MARK: - Private Properties

    private let presenter: MyGamesPresenterProtocol

    private lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = AppFont.Quantex.regular(size: 16)
        return view
    }()

    // MARK: - Initializers

    init(presenter: MyGamesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter.viewDidLoad()
    }

    // MARK: - Public Methods

    func showGreeting(_ message: String) {
        label.text = message
    }

    func displayError(message: String) {
		// TODO:
        print(message)
    }

    // MARK: - Layout

    private func setupView() {
        view.addSubview(label)
        setupLayout()
    }

    private func setupLayout() {
		label.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
    }
}
