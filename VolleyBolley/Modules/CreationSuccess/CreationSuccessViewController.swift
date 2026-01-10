//
//  CreationSuccessViewController.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 10.09.2025.
//

import UIKit

protocol CreationSuccessView: AnyObject {
    func reloadData()
    func showError(_ error: Error)
}

final class CreationSuccessViewController: BaseViewController, CreationSuccessView {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 32
        static let rowHeight: CGFloat = 52
        static let containerHeight: CGFloat = 332
        static let containerInsets: CGFloat = 8
        static let vStackSpacing: CGFloat = 8
        static let hStackSpacing: CGFloat = 8
        static let hStackOffset: CGFloat = 8
        static let contentInsets: CGFloat = 20
    }

    // MARK: - Private Properties

    private lazy var titleLabel: CustomTitle = {
        CustomTitle(text: presenter.titleText, isLarge: true)
    }()

    private lazy var infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(
            CreationSuccessInfoCell.self,
            forCellReuseIdentifier: CreationSuccessInfoCell.reuseIdentifier
        )
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.rowHeight
        tableView.isScrollEnabled = false
        return tableView
    }()

    private lazy var doneButton: YellowButton = {
        let button = YellowButton()
        button.setTitle(String(localized: "customAlertView.button.done"), for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()

    private lazy var inviteButton: SketchButton = {
        let button = SketchButton(type: .invitePlayers, isSelected: true)
        button.addTarget(self, action: #selector(didTapInviteButton), for: .touchUpInside)
        return button
    }()

    private lazy var shareButton: SketchButton = {
        let button = SketchButton(type: .shareLink)
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        return button
    }()

    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, infoTableView, doneButton])
        stack.axis = .vertical
        stack.spacing = Constants.vStackSpacing
        return stack
    }()

    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [inviteButton, shareButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = Constants.hStackSpacing
        return stack
    }()

    private lazy var glassContainer: GlassmorphismView = {
        let view = GlassmorphismView()
        view.cornerRadius = Constants.cornerRadius
        return view
    }()

    private var tableHeightConstraint: NSLayoutConstraint?

    private let presenter: CreationSuccessPresenterProtocol

    // MARK: - Initializers

    init(presenter: CreationSuccessPresenterProtocol) {
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
        setup()
        presenter.viewDidLoad()
    }

    // MARK: - Internal Methods

    func reloadData() {
        infoTableView.reloadData()
        tableHeightConstraint?.constant = Constants.rowHeight * CGFloat(presenter.numberOfItems)
    }

    func showError(_ error: Error) {
        print(error)
    }

    // MARK: - Private Methods

    private func setup() {
        view.addSubviews(glassContainer, vStack, hStack)

        tableHeightConstraint = infoTableView.heightAnchor.constraint(
            equalToConstant: Constants.rowHeight * CGFloat(presenter.numberOfItems)
        )
        tableHeightConstraint?.isActive = true

        NSLayoutConstraint.activate(
            [
                glassContainer.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.containerInsets
                ),
                glassContainer.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Constants.containerInsets
                ),
                glassContainer.topAnchor.constraint(
					equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: Constants.containerInsets
                ),
                glassContainer.heightAnchor.constraint(
                    equalToConstant: Constants.containerHeight
                ),

                vStack.leadingAnchor.constraint(
                    equalTo: glassContainer.leadingAnchor,
                    constant: Constants.contentInsets
                ),
                vStack.trailingAnchor.constraint(
                    equalTo: glassContainer.trailingAnchor,
                    constant: -Constants.contentInsets
                ),
                vStack.topAnchor.constraint(
                    equalTo: glassContainer.topAnchor,
                    constant: Constants.contentInsets
                ),

                hStack.leadingAnchor.constraint(equalTo: glassContainer.leadingAnchor),
                hStack.trailingAnchor.constraint(equalTo: glassContainer.trailingAnchor),
                hStack.topAnchor.constraint(equalTo: glassContainer.bottomAnchor, constant: Constants.hStackOffset)
            ]
        )
    }

    @objc private func didTapDoneButton() {
        presenter.didTapDone()
    }

    @objc private func didTapInviteButton() {
        presenter.didTapInvite()
    }

    @objc private func didTapShareButton() {
        presenter.didTapShare()
    }
}

// MARK: - UITableViewDataSource

extension CreationSuccessViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CreationSuccessInfoCell.reuseIdentifier,
            for: indexPath
        ) as? CreationSuccessInfoCell else {
            return UITableViewCell()
        }

        cell.configure(with: presenter.infoItem(at: indexPath.row))

        return cell
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

final class MockCreationSuccessPresenter: CreationSuccessPresenterProtocol {
    var numberOfItems: Int { 4 }
    var titleText: String { "Game created" }

    func infoItem(at index: Int) -> CreationInfoItem {
        switch index {
        case 0:
            CreationInfoItem(type: .place, title: "Karon Beach Club", description: "Patak Rd, Mueang Phuket")
        case 1:
            CreationInfoItem(type: .time, title: "Starts today", description: "2:00 - 3:00 pm")
        case 2:
            CreationInfoItem(type: .level, title: "Level: Hard", description: "Mix · 4 players · private game")
        case 3:
            CreationInfoItem(type: .price, title: "5$ per person", description: "988 016 7890")
        default:
            CreationInfoItem(type: .place, title: "", description: "")
        }
    }

    func didTapDone() {}
    func didTapInvite() {}
    func didTapShare() {}
    func viewDidLoad() {}
}

@available(iOS 17.0, *)
#Preview {
    CreationSuccessViewController(presenter: MockCreationSuccessPresenter())
}
#endif
