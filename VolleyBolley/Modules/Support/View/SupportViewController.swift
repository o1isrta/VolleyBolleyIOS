//
//  SupportViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

import MessageUI
import UIKit

// MARK: - SupportViewControllerProtocol

protocol SupportViewControllerProtocol: AnyObject {
	func sendEmail()
}

// MARK: - SupportViewController

final class SupportViewController: BaseViewController {

	// MARK: - Constants

	private enum Constants {
		static let buttonSize: CGFloat = 24
		static let padding: CGFloat = 8
		static let tableTopInset: CGFloat = 4
		static let topInset: CGFloat = 20
		static let titleFontSize: CGFloat = 24
		static let initialTableHeight: CGFloat = 0
	}

	// MARK: - Private Properties

	private let presenter: SupportPresenterProtocol

	private lazy var glassmorphismView = GlassmorphismView()

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "Support"), isBold: true)
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
		tableView.delegate = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 80
		tableView.register(SupportCell.self, forCellReuseIdentifier: SupportCell.reuseIdentifier)
		return tableView
	}()

	private lazy var customAlertView: CustomAlertView = {
		let view = CustomAlertView()
		view.isHidden = true
		return view
	}()

	// MARK: - Initializers

	init(presenter: SupportPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupTableViewContentSizeObserver()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		// ALWAYS raise the customAlertView above all other subviews
		view.bringSubviewToFront(customAlertView)
	}
}

// MARK: - SupportViewControllerProtocol

extension SupportViewController: SupportViewControllerProtocol {

	func sendEmail() {
		guard MFMailComposeViewController.canSendMail() else {
			let message = String(localized: "emailToSupport.doNotConfigured")
			showAlert(with: message)
			return
		}
		let mailComposer = MFMailComposeViewController()
		mailComposer.mailComposeDelegate = self
		mailComposer.setToRecipients([AppConstants.Contacts.email])
		mailComposer.setSubject(String(localized: "emailToSupport.subject"))

		let message = """
			\(String(localized: "emailToSupport.greetings"))

			\(String(localized: "emailToSupport.message")):
			"""
		let basicDiagnostics = DiagnosticsManager.generatePlainTextBody(with: message)

		mailComposer.setMessageBody(basicDiagnostics, isHTML: false)
		present(mailComposer, animated: true)
	}
}

// MARK: - Private Methods

private extension SupportViewController {

	func showAlert(with message: String) {
		customAlertView.isHidden = false
		let model = CustomAlertModel(
			message: message,
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.ok"),
				action: { self.customAlertView.isHidden = true }
			)
		)
		customAlertView.configure(with: model)
	}

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
			let maxHeight = UIScreen.main.bounds.height - 315
			let newHeight = min(newSize.height, maxHeight)
			self.tableViewHeightConstraint?.constant = newHeight
		}
	}

	func setupView() {
		view.addSubviews(
			glassmorphismView,
			tableView,
			titleLabel,
			backButton,
			customAlertView
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

			customAlertView.topAnchor.constraint(equalTo: view.topAnchor),
			customAlertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			customAlertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			customAlertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

		tableViewHeightConstraint = tableView.heightAnchor.constraint(
			equalToConstant: Constants.initialTableHeight
		)
		tableViewHeightConstraint?.isActive = true
	}
}

// MARK: - UITableViewDataSource

extension SupportViewController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		SupportItem.allCases.count
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: SupportCell.reuseIdentifier,
			for: indexPath
		) as? SupportCell else {
			return UITableViewCell()
		}
		let item = SupportItem.allCases[indexPath.row]
		let isLast = indexPath.row == SupportItem.allCases.count - 1
		cell.configure(with: item, isLast: isLast)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension SupportViewController: UITableViewDelegate {

	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
		tableView.deselectRow(at: indexPath, animated: true)
		let item = SupportItem.allCases[indexPath.row]
		presenter.didSelectSupportItem(item)
	}
}

// MARK: - MFMailComposeViewControllerDelegate

extension SupportViewController: MFMailComposeViewControllerDelegate {

	func mailComposeController(
		_ controller: MFMailComposeViewController,
		didFinishWith result: MFMailComposeResult,
		error: Error?
	) {
		controller.dismiss(animated: true)
		guard result == .sent else { return }
		let message = String(localized: "emailToSupport.succesfullySent")
		showAlert(with: message)
	}
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct SupportViewControllerPreview: UIViewControllerRepresentable {

	class StubPresenter: SupportPresenterProtocol {
		weak var view: SupportViewControllerProtocol?
		func viewDidLoad() {}
		func backButtonTapped() {}
		func didSelectSupportItem(_ item: SupportItem) {}
	}

	func makeUIViewController(context: Context) -> some UIViewController {
		let presenter = StubPresenter()
		let supportView = SupportViewController(presenter: presenter)
		presenter.view = supportView
		return supportView
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct SupportViewController_Previews: PreviewProvider {
	static var previews: some View {
		SupportViewControllerPreview()
			.edgesIgnoringSafeArea(.all)
	}
}
#endif
