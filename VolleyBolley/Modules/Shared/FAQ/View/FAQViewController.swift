//
//  FAQViewController.swift
//  VolleyBolley
//
//  Created by Вадим on 02.09.2025.
//

import UIKit

protocol FAQViewControllerProtocol: AnyObject {
	func reloadTableView()
}

final class FAQViewController: BaseViewController {

	// MARK: - Private Properties

	private let presenter: FAQPresenterProtocol

	private lazy var buttonBack: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
			self?.presenter.didTapBackButton()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var titleLabel = CustomTitle(
		text: String(localized: "FAQ"),
		isLarge: true
	)

	private lazy var background = GlassmorphismView()

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = true
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.register(FAQTableViewCell.self, forCellReuseIdentifier: FAQTableViewCell.faqId)
		return tableView
	}()

	// MARK: - Initializers

	init(presenter: FAQPresenterProtocol) {
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

// MARK: - FAQViewControllerProtocol

extension FAQViewController: FAQViewControllerProtocol {

	func reloadTableView() {
		tableView.reloadData()
	}
}

// MARK: - Private methods

private extension FAQViewController {

	func setupUI() {
		view.addSubviews(
			background,
			buttonBack,
			titleLabel,
			tableView
		)
	}

	func setupView() {
		setupUI()

		let contentInset: CGFloat = 8
		let mainSpacing: CGFloat = 20

		NSLayoutConstraint.activate([
			background.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: contentInset),
			background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentInset),
			background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -contentInset),
			background.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55),

			buttonBack.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: mainSpacing),
			buttonBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: mainSpacing),

			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor),

			tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
			tableView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: mainSpacing),
			tableView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -mainSpacing),
			tableView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -mainSpacing)
		])
	}
}

// MARK: - UITableViewDataSource

extension FAQViewController: UITableViewDataSource {

	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		return presenter.numberOfItems
	}

	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(
				withIdentifier: FAQTableViewCell.faqId,
				for: indexPath) as? FAQTableViewCell
		else {
			return UITableViewCell()
		}
		let item = presenter.item(at: indexPath.row)
		let isLastItem = indexPath.row == presenter.numberOfItems - 1
		let model = FAQTableViewCellViewModel(
			faqItem: item,
			isLastItem: isLastItem
		)
		cell.configure(with: model)
		return cell
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	let router = FAQRouter()
	let interactor = FAQInteractor()
	let presenter = FAQPresenter(interactor: interactor, router: router)
	let view = FAQViewController(presenter: presenter)
	router.attachViewController(view)
	presenter.view = view
	return view
}
#endif
