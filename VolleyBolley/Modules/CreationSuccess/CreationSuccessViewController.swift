//
//  CreationSuccessViewController.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 10.09.2025.
//

import UIKit

enum CreationType {
    case game
    case tourney

    var titleText: String {
        switch self {
        case .game: return "Game created"
        case .tourney: return "Tourney created"
        }
    }
}

final class CreationSuccessViewController: BaseViewController {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 32
        static let rowHeight: CGFloat = 52
        static let vStackSpacing: CGFloat = 8
        static let hStackSpacing: CGFloat = 8
        static let hStackOffset: CGFloat = 8
        static let insets: CGFloat = 20
    }

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.type.titleText
        label.font = AppFont.ActayWide.bold(size: 24)
        label.textColor = AppColor.Text.primary
        return label
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
        button.setTitle("DONE", for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()

    private lazy var inviteButton: SketchButton = {
        let button = SketchButton(
            title: "Invite players",
            image: UIImage.Icon.invitePlayers
        )
        button.isSelected = true
        button.addTarget(self, action: #selector(didTapInviteButton), for: .touchUpInside)
        return button
    }()

    private lazy var shareButton: SketchButton = {
        let button = SketchButton(
            title: "Share link",
            image: UIImage.Icon.share
        )
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

    private let type: CreationType
    private let infoItems = [
        CreationInfoItem(type: .place, title: "Karon Beach Club", description: "Patak Rd, Mueang Phuket"),
        CreationInfoItem(type: .time, title: "Starts today", description: "2:00-3:00 pm"),
        CreationInfoItem(type: .level, title: "Level: Hard", description: "Mix · 4 teams"),
        CreationInfoItem(type: .price, title: "5$ per person", description: "988 016 7890")
    ]

    // MARK: - Initializers

    init(creationType: CreationType = .game) {
        type = creationType
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
    }

    // MARK: - Private Methods

    private func setup() {
        view.addSubviews(glassContainer, vStack, hStack)

        NSLayoutConstraint.activate(
            [
                glassContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                glassContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                glassContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                glassContainer.heightAnchor.constraint(equalToConstant: 332),

                infoTableView.heightAnchor.constraint(equalToConstant: Constants.rowHeight * CGFloat(infoItems.count)),

                vStack.leadingAnchor.constraint(equalTo: glassContainer.leadingAnchor, constant: 20),
                vStack.trailingAnchor.constraint(equalTo: glassContainer.trailingAnchor, constant: -20),
                vStack.topAnchor.constraint(equalTo: glassContainer.topAnchor, constant: 20),

                hStack.leadingAnchor.constraint(equalTo: glassContainer.leadingAnchor),
                hStack.trailingAnchor.constraint(equalTo: glassContainer.trailingAnchor),
                hStack.topAnchor.constraint(equalTo: glassContainer.bottomAnchor, constant: Constants.hStackOffset)
            ]
        )
    }

    @objc private func didTapDoneButton() {}

    @objc private func didTapInviteButton() {}

    @objc private func didTapShareButton() {}
}

// MARK: - UITableViewDataSource

extension CreationSuccessViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CreationSuccessInfoCell.reuseIdentifier,
            for: indexPath
        ) as? CreationSuccessInfoCell else {
            return UITableViewCell()
        }

        cell.configure(with: infoItems[indexPath.row])

        return cell
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
    UIViewControllerPreview {
        CreationSuccessViewController()
    }
    .edgesIgnoringSafeArea(.all)
}
#endif
