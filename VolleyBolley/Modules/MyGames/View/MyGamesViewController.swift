//
//  MyGamesViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

protocol MyGamesViewProtocol: AnyObject where Self: UIViewController {
	@MainActor
	func reloadData()
}

final class MyGamesViewController: BaseViewController {

    // MARK: - Private Properties

	private let presenter: MyGamesPresenterProtocol

	private enum Constants {
		static let cornerRadius: CGFloat = 32
		static let padding: CGFloat = 8

		static let estimatedRowHeight: CGFloat = 44
		static let initialTableHeight: CGFloat = 237
	}

	private lazy var backgroundView: GlassmorphismView = GlassmorphismView()

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.layer.cornerRadius = Constants.cornerRadius
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = Constants.estimatedRowHeight
		tableView.register(MyGamesCell.self, forCellReuseIdentifier: MyGamesCell.reuseIdentifier)
		return tableView
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
        setupUI()
        presenter.viewDidLoad()
    }

    // MARK: - Public Methods
}

// MARK: - Private Methods

private extension MyGamesViewController {

	func setupUI() {
		view.addSubviews(
			backgroundView,
			tableView
		)
		NSLayoutConstraint.activate([
			backgroundView.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: Constants.padding
			),
			backgroundView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Constants.padding
			),
			backgroundView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Constants.padding
			),
			backgroundView.bottomAnchor.constraint(
				equalTo: tableView.bottomAnchor,
				constant: Constants.padding
			),

			tableView.topAnchor.constraint(
				equalTo: backgroundView.topAnchor
			),
			tableView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Constants.padding
			),
			tableView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Constants.padding
			),
			tableView.heightAnchor.constraint(
				equalToConstant: Constants.initialTableHeight
			)
		])
	}
}

// MARK: - MyGamesViewProtocol

extension MyGamesViewController: MyGamesViewProtocol {

	func reloadData() {
		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource

extension MyGamesViewController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		presenter.getItemsCount()
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: MyGamesCell.reuseIdentifier,
			for: indexPath
		) as? MyGamesCell else {
			return UITableViewCell()
		}
		let item = presenter.getItemData(index: indexPath.row)
		let isLast = presenter.isLastItem(index: indexPath.row)
		cell.configure(with: item, isLast: isLast)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension MyGamesViewController: UITableViewDelegate {

	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
		tableView.deselectRow(at: indexPath, animated: true)
		presenter.didSelectMenuItem(at: indexPath.row)
	}
}
