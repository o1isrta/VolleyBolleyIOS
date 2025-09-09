//
//  AboutViewController.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import UIKit

// MARK: - Protocol

protocol AboutViewProtocol: AnyObject {
    func displayAboutInfo(_ viewModel: AboutViewModel)
}

// MARK: - ViewModel

struct AboutViewModel {
    let founder: String
    let designers: [String]
    let developers: [String]
}

// MARK: - Item for Table

struct AboutItem {
    let title: String
    let value: String
}

// MARK: - ViewController

final class AboutViewController: BaseViewController, AboutViewProtocol {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 32
        static let buttonSize: CGFloat = 24
        static let padding: CGFloat = 16
        static let topInset: CGFloat = 20
        static let titleFontSize: CGFloat = 24
        static let animationDuration: TimeInterval = 0.15
        static let initialTableHeight: CGFloat = 240
    }

    // MARK: - Private Properties

    private let presenter: AboutPresenterProtocol
    private var items: [AboutItem] = []

    private lazy var tableBackground: GlassmorphismView = {
        let view = GlassmorphismView()
        view.cornerRadius = Constants.cornerRadius
        return view
    }()

    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(text: String(localized: "About"), isBold: true)
        label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
        label.textColor = .white
        label.textAlignment = .center
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
        tableView.register(AboutCell.self, forCellReuseIdentifier: AboutCell.reuseIdentifier)
        return tableView
    }()

    private var tableBackgroundHeightConstraint: NSLayoutConstraint?

    // MARK: - Init

    init(presenter: AboutPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    // MARK: - Public Methods

    func displayAboutInfo(_ viewModel: AboutViewModel) {
        items = [
            AboutItem(
                title: String(localized: "Founder"),
                value: viewModel.founder
            ),
            AboutItem(
                title: String(localized: "Designed by"),
                value: viewModel.designers.joined(separator: ", ")
            ),
            AboutItem(
                title: String(localized: "Developed by"),
                value: viewModel.developers.joined(separator: ", ")
            )
        ]

        tableView.reloadData()
        tableView.layoutIfNeeded()

        let topPart = Constants.topInset + Constants.buttonSize
        tableBackgroundHeightConstraint?.constant = topPart + tableView.contentSize.height

        UIView.animate(withDuration: Constants.animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Private Methods

    private func setupView() {
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
                equalTo: view.safeAreaLayoutGuide.topAnchor,
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

    @objc private func backButtonTapped() {
        dismiss(animated: true)
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

// MARK: - UITableViewDelegate

extension AboutViewController: UITableViewDelegate {

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

struct AboutViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: AboutPresenterProtocol {
        weak var view: AboutViewProtocol?
        func viewDidLoad() {
            let aboutViewModel = AboutViewModel(
                founder: "Dmitrii Zverev",
                designers: ["Malika Rozieva", "Zemlyanskaya Yulia"],
                developers: []
            )
            view?.displayAboutInfo(aboutViewModel)
        }
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
