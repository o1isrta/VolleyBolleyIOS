//
//  AboutViewController.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import UIKit

// MARK: - AboutViewProtocol

protocol AboutViewProtocol: AnyObject {
	func displayAboutInfo(_ viewModel: AboutViewModel)
}

// MARK: - AboutViewModel

struct AboutViewModel {
	let founder: String
	let designers: [String]
	let developers: [String]
	let appVersion: String
	let appBuild: String
}

// MARK: - AboutItem

struct AboutItem {
	let title: String
	let value: String
}

// MARK: - ViewController

final class AboutViewController: BaseViewController {

	// MARK: - Constants

	private enum Constants {
		static let buttonSize: CGFloat = 24
		static let padding: CGFloat = 8
		static let tableTopInset: CGFloat = 4
		static let topInset: CGFloat = 20
		static let titleFontSize: CGFloat = 24
		static let versionFontSize: CGFloat = 14
		static let initialTableHeight: CGFloat = 0
	}

	// MARK: - Private Properties

	private let presenter: AboutPresenterProtocol
	private var items: [AboutItem] = []

	private lazy var glassmorphismView = GlassmorphismView()

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "About"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		return label
	}()

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
			self?.presenter.backButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private var tableViewHeightConstraint: NSLayoutConstraint?
	private var tableViewContentSizeObserver: NSKeyValueObservation?
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = false
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44
		tableView.register(AboutCell.self, forCellReuseIdentifier: AboutCell.reuseIdentifier)
		return tableView
	}()

	private lazy var versionLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColor.Text.primary
		label.font = AppFont.Hero.light(size: Constants.versionFontSize)
		return label
	}()

	// MARK: - Initializers

	init(presenter: AboutPresenterProtocol) {
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
		setupTableViewContentSizeObserver()
	}
}

// MARK: - AboutViewProtocol

extension AboutViewController: AboutViewProtocol {

	func displayAboutInfo(_ viewModel: AboutViewModel) {
		items = [
			AboutItem(
				title: String(localized: "Founder"),
				value: viewModel.founder
			),
			AboutItem(
				title: String(localized: "Designed by"),
				value: viewModel.designers.joined(separator: "\n")
			),
			AboutItem(
				title: String(localized: "Developed by"),
				value: viewModel.developers.joined(separator: "\n")
			)
		]
		tableView.reloadData()

		let appVersion = "\(String(localized: "Version")) \(viewModel.appVersion)"
		let appAssembly = "\(String(localized: "Build")) \(viewModel.appBuild)"
		versionLabel.text = "\(appVersion)  \(appAssembly)"
	}
}

// MARK: - Private Methods

private extension AboutViewController {

	func setupTableViewContentSizeObserver() {
		tableViewContentSizeObserver = tableView.observe(
			\.contentSize,
			 options: [.new]
		) { [weak self] _, change in
			guard
				let self,
				let newSize = change.newValue
			else { return }
			// Limiting the max height to preserve scrolling
			let maxHeight = UIScreen.main.bounds.height - 355
			let newHeight = min(newSize.height, maxHeight)
			self.tableViewHeightConstraint?.constant = newHeight
		}
	}

	func setupView() {
		view.addSubviews(
			glassmorphismView,
			backButton,
			titleLabel,
			tableView,
			versionLabel
		)
		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: Constants.padding
			),
			glassmorphismView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Constants.padding
			),
			glassmorphismView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Constants.padding
			),
			glassmorphismView.bottomAnchor.constraint(
				equalTo: tableView.bottomAnchor
			),

			backButton.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: Constants.topInset
			),
			backButton.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: Constants.topInset
			),
			backButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
			backButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),

			titleLabel.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

			tableView.topAnchor.constraint(
				equalTo: backButton.bottomAnchor,
				constant: Constants.tableTopInset
			),
			tableView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor),

			versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
		])

		tableViewHeightConstraint = tableView.heightAnchor.constraint(
			equalToConstant: Constants.initialTableHeight
		)
		tableViewHeightConstraint?.isActive = true
	}
}

// MARK: - UITableViewDataSource

extension AboutViewController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		items.count
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: AboutCell.reuseIdentifier,
			for: indexPath
		) as? AboutCell else {
			return UITableViewCell()
		}

		let item = items[indexPath.row]
		let isLast = indexPath.row == items.count - 1
		cell.configure(with: item, isLast: isLast)

		return cell
	}
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct AboutViewControllerPreview: UIViewControllerRepresentable {
	class StubPresenter: AboutPresenterProtocol {
		weak var view: AboutViewProtocol?
		func viewDidLoad() {
			let aboutViewModel = AboutViewModel(
				founder: "Dmitrii Zverev",
				designers: ["Malika Rozieva", "Yulia Zemlyanskaya"],
				developers: ["Team VolleyBolley"],
				appVersion: "1.0.0",
				appBuild: "1"
			)
			view?.displayAboutInfo(aboutViewModel)
		}
		func backButtonTapped() {}
	}

	func makeUIViewController(context: Context) -> some UIViewController {
		let presenter = StubPresenter()
		let aboutView = AboutViewController(presenter: presenter)
		presenter.view = aboutView
		return aboutView
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct AboutViewController_Previews: PreviewProvider {
	static var previews: some View {
		AboutViewControllerPreview()
			.edgesIgnoringSafeArea(.all)
	}
}
#endif
