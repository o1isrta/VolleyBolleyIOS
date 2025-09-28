//
//  PhotoActionsTableView.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 11.09.2025.
//
#if DEBUG
import SwiftUI
#endif
import UIKit

private enum PhotoActionsConstants {
    static let actions: [(icon: String, title: String)] = [
        ("photo", String(localized: "Choose from Gallery")),
        ("camera", String(localized: "Take photo")),
        ("trash", String(localized: "Delete photo"))
    ]
}

final class PhotoActionsTableView: UIView {

    var didSelectAction: ((Int) -> Void)?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.layer.cornerRadius = 32
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .separator
        tableView.register(ActionCell.self, forCellReuseIdentifier: "ActionCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension PhotoActionsTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhotoActionsConstants.actions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as? ActionCell else {
            return UITableViewCell()
        }
        let action = PhotoActionsConstants.actions[indexPath.row]
        cell.configure(iconName: action.0, title: action.1)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle selection
        didSelectAction?(indexPath.row)
    }
}

// MARK: ActionCell, custom cell class
class ActionCell: UITableViewCell {
    func configure(iconName: String, title: String) {
        var content = defaultContentConfiguration()
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        content.image = UIImage(systemName: iconName, withConfiguration: config)
        content.imageProperties.tintColor = AppColor.Text.inverted
        content.text = title
        content.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        content.textProperties.color = AppColor.Text.inverted
        contentConfiguration = content
    }
}

// Обертка для SwiftUI Preview
struct PhotoActionsTableViewPreview: UIViewRepresentable {

    func makeUIView(context: Context) -> PhotoActionsTableView {
        PhotoActionsTableView()
    }

    func updateUIView(_ uiViewController: PhotoActionsTableView, context: Context) {}
}

#Preview {
    PhotoActionsTableViewPreview()
}
