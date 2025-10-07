//
//  SupportViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

import MessageUI
import UIKit

// MARK: - Protocol

protocol SupportViewProtocol: AnyObject {
	func displaySupportInfo(_ viewModel: SupportViewModel)
}

// MARK: - ViewModel

struct SupportViewModel {
	let faq: String
	let email: String
}

// MARK: - Item for Table

struct SupportItem {
	let title: String
	let value: String
}

// MARK: - ViewController

final class SupportViewController: BaseViewController {

	// MARK: - Constants

	private enum Constants {
		static let cornerRadius: CGFloat = 32
		static let buttonSize: CGFloat = 24
		static let padding: CGFloat = 8
		static let topInset: CGFloat = 20
		static let titleFontSize: CGFloat = 24
		static let initialTableHeight: CGFloat = 240
	}

	// MARK: - Private Properties

	private let presenter: SupportPresenterProtocol
	// TODO: -
	private var items: [SupportItem] = [
		SupportItem(
			   title: String(localized: "support.faq"),
			   value: String(localized: "support.faq.description")
		   ),
		   SupportItem(
			   title: String(localized: "support.linktree"),
			   value: String(localized: "support.linktree.description")//"https://linktr.ee/volleybolley.app"
		   ),
		   SupportItem(
			   title: String(localized: "support.contactUs"),
			   value: AppConstants.Contacts.email
		   ),
		   SupportItem(
			   title: String(localized: "support.whatsApp"),
			   value: String(localized: "support.whatsApp.description")//"https://wa.me/message/LEFHH2AQMSE3D1"
		   )
	   ]

	private lazy var tableBackground: GlassmorphismView = {
		let view = GlassmorphismView()
		view.cornerRadius = Constants.cornerRadius
		return view
	}()

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "Support"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		return label
	}()

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addTarget(
			self,
			action: #selector(backButtonTapped),
			for: .touchUpInside
		)
		return button
	}()

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.layer.cornerRadius = Constants.cornerRadius
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44
		tableView.register(SupportCell.self, forCellReuseIdentifier: SupportCell.reuseIdentifier)
		return tableView
	}()

	private var tableBackgroundHeightConstraint: NSLayoutConstraint?// TODO: -

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
		presenter.viewDidLoad()
	}
}

// MARK: - Private Methods

private extension SupportViewController {

	func setupView() {
		view.addSubviews(tableBackground)

		tableBackground.addSubviews(
			backButton,
			titleLabel,
			tableView
		)

		tableBackgroundHeightConstraint = tableBackground.heightAnchor.constraint(
			equalToConstant: Constants.initialTableHeight
		)
		tableBackgroundHeightConstraint?.isActive = true

		NSLayoutConstraint.activate([
			tableBackground.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: Constants.padding
			),
			tableBackground.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Constants.padding
			),
			tableBackground.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Constants.padding
			),

			backButton.topAnchor.constraint(
				equalTo: tableBackground.topAnchor,
				constant: Constants.topInset
			),
			backButton.leadingAnchor.constraint(
				equalTo: tableBackground.leadingAnchor,
				constant: Constants.topInset
			),
			backButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
			backButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),

			titleLabel.centerXAnchor.constraint(equalTo: tableBackground.centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

			tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: tableBackground.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: tableBackground.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: tableBackground.bottomAnchor)
		])
	}

	@objc func backButtonTapped() {
		presenter.backButtonTapped()
	}

	private func sendEmail() {
		guard MFMailComposeViewController.canSendMail() else {
			// TODO: -
			print(String(localized: "emailToSupport.doNotConfigured"))
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

// MARK: - SupportViewProtocol

extension SupportViewController: SupportViewProtocol {

	func displaySupportInfo(_ viewModel: SupportViewModel) {
		// TODO: - 
		items = [
			SupportItem(
				title: String(localized: "support.faq"),
				value: String(localized: "support.faq.description")
			),
			SupportItem(
				title: String(localized: "support.linktree"),
				value: String(localized: "support.linktree.description")//"https://linktr.ee/volleybolley.app"
			),
			SupportItem(
				title: String(localized: "support.contactUs"),
				value: viewModel.email
			),
			SupportItem(
				title: String(localized: "support.whatsApp"),
				value: String(localized: "support.whatsApp.description")//"https://wa.me/message/LEFHH2AQMSE3D1"
			)
		]

		tableView.reloadData()
		tableView.layoutIfNeeded()

		let topPart = Constants.topInset + Constants.buttonSize
		tableBackgroundHeightConstraint?.constant = topPart + tableView.contentSize.height
	}
}

// MARK: - UITableViewDataSource

extension SupportViewController: UITableViewDataSource {

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
			withIdentifier: SupportCell.reuseIdentifier,
			for: indexPath
		) as? SupportCell else {
			return UITableViewCell()
		}

		let item = items[indexPath.row]
		let isLast = indexPath.row == items.count - 1
		cell.configure(with: item, isLast: isLast)

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let item = items[indexPath.row]
		// TODO: -
		switch indexPath.row {
		case 0:
			presenter.faqTapped()
		case 1:
			sendEmail()
			//		case .faq:
			//			navigationController?.pushViewController(FAQViewController(), animated: true)
			//		case .website:
			//			openWebsite()
			//		}
		default: break
		}
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
		// Можно показать благодарность за обращение, если result == .sent // TODO: -
	}
}

// MARK: - UITableViewDelegate

extension SupportViewController: UITableViewDelegate {

	func tableView(
		_ tableView: UITableView,
		heightForRowAt indexPath: IndexPath
	) -> CGFloat {
		UITableView.automaticDimension
	}
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct SupportViewControllerPreview: UIViewControllerRepresentable {

	class StubPresenter: SupportPresenterProtocol {
		weak var view: SupportViewProtocol?
		func viewDidLoad() {
			let supportViewModel = SupportViewModel(
				faq: "The answer may already be here",
				email: AppConstants.Contacts.email
			)
			view?.displaySupportInfo(supportViewModel)
		}
		func backButtonTapped() {}
		func faqTapped() {}
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
