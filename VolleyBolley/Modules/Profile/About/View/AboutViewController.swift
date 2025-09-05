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

    private let presenter: AboutPresenterProtocol
    private var items: [AboutItem] = []

    private lazy var tableBackground: GlassmorphismView = {
        let view = GlassmorphismView()
        view.cornerRadius = 32
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 32
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AboutCell.self, forCellReuseIdentifier: AboutCell.reuseIdentifier)
        return tableView
    }()

    init(presenter: AboutPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    func displayAboutInfo(_ viewModel: AboutViewModel) {
        var newItems: [AboutItem] = []

        newItems.append(AboutItem(title: "Founder", value: viewModel.founder))
        newItems.append(AboutItem(title: "Designed by", value: viewModel.designers.joined(separator: ", ")))

        let devs = viewModel.developers.isEmpty ? "—" : viewModel.developers.joined(separator: ", ")
        newItems.append(AboutItem(title: "Developed by", value: devs))

        items = newItems
        tableView.reloadData()
    }

    private func setupView() {
        [tableBackground, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            tableBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableBackground.heightAnchor.constraint(equalToConstant: 240),

            tableView.topAnchor.constraint(equalTo: tableBackground.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableBackground.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableBackground.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableBackground.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension AboutViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AboutCell.reuseIdentifier,
            for: indexPath
        ) as? AboutCell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

#if DEBUG
import SwiftUI

struct AboutViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: AboutPresenterProtocol {
        weak var view: AboutViewProtocol?
        func viewDidLoad() {
            let vm = AboutViewModel(
                founder: "Dmitrii Zverev",
                designers: ["Malika Rozieva", "Zemlyanskaya Yulia"],
                developers: []
            )
            view?.displayAboutInfo(vm)
        }
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let presenter = StubPresenter()
        let vc = AboutViewController(presenter: presenter)
        presenter.view = vc
        return vc
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
