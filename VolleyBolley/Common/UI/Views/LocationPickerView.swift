//
//  LocationPickerView.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import UIKit

protocol LocationPickerViewDelegate: AnyObject {
    func locationPickerView(_ pickerView: LocationPickerView, didSelectItem item: String)
}

/// Переиспользуемый кастомный раскрывающийся список
class LocationPickerView: UIView, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: LocationPickerViewDelegate?

    private let titleContainer: UIView = {
        let titleContainer = UIView()
        titleContainer.backgroundColor = .white
        titleContainer.layer.cornerRadius = 16
        titleContainer.layer.borderWidth = 1
        titleContainer.layer.borderColor = .init(gray: 0.8, alpha: 1)
        titleContainer.clipsToBounds = true
        titleContainer.isUserInteractionEnabled = true
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        return titleContainer
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = AppColor.Text.placeHolder
        titleLabel.font = AppFont.Hero.regular(size: 16)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    private let arrowImageView: UIImageView = {
        let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        arrowImageView.tintColor = AppColor.Icon.inverted
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        return arrowImageView
    }()

    private let tableContainer: UIView = {
        let tableContainer = UIView()
        tableContainer.translatesAutoresizingMaskIntoConstraints = false
        tableContainer.backgroundColor = .white
        tableContainer.layer.cornerRadius = 16
        tableContainer.layer.borderWidth = 1
        tableContainer.layer.borderColor = AppColor.Border.primary.cgColor
        tableContainer.clipsToBounds = true
        tableContainer.isHidden = true
        tableContainer.alpha = 0
        return tableContainer
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true

        tableView.backgroundColor = .white
        tableView.separatorInset = .zero
        return tableView
    }()

    private let cellIdentifier = "LocationCell"

    private var heightConstraint: NSLayoutConstraint?
    private var tableHeightConstraint: NSLayoutConstraint?
    private var isOpen = false
    private let rowHeight: CGFloat = 51
    private let closedHeight: CGFloat = 51
    private let maxTableHeight: CGFloat = 102

    private var items: [String]

    var placeholder: String {
        didSet {
            if selectedItem == nil {
                titleLabel.text = placeholder
            }
        }
    }

    private var selectedItem: String? {
        didSet {
            titleLabel.text = selectedItem ?? placeholder
        }
    }

    init(items: [String], placeholder: String = "Select") {
        self.items = items
        self.placeholder = placeholder
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleTableView))
        titleContainer.addGestureRecognizer(tap)

        addSubview(titleContainer)
        addSubview(tableContainer)

        titleContainer.addSubview(titleLabel)
        titleContainer.addSubview(arrowImageView)
        tableContainer.addSubview(tableView)

        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: topAnchor),
            titleContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleContainer.heightAnchor.constraint(equalToConstant: closedHeight),

            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),

            arrowImageView.centerYAnchor.constraint(equalTo: titleContainer.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -12),
            arrowImageView.widthAnchor.constraint(equalToConstant: 14),
            arrowImageView.heightAnchor.constraint(equalToConstant: 7),

            tableContainer.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 6),
            tableContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableContainer.trailingAnchor.constraint(equalTo: trailingAnchor),

            tableView.topAnchor.constraint(equalTo: tableContainer.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableContainer.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableContainer.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableContainer.bottomAnchor)
        ])

        titleLabel.text = placeholder

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        tableHeightConstraint = tableContainer.heightAnchor.constraint(equalToConstant: 0)
        tableHeightConstraint?.isActive = true

        heightConstraint = heightAnchor.constraint(equalToConstant: closedHeight)
        heightConstraint?.isActive = true
    }

    @objc func toggleTableView() {
        isOpen.toggle()
        tableContainer.isHidden = false

        let tableContentHeight = CGFloat(items.count) * rowHeight
        let adjustedTableHeight = min(tableContentHeight, maxTableHeight)
        let totalHeight = isOpen ? closedHeight + adjustedTableHeight : closedHeight

        tableHeightConstraint?.constant = isOpen ? adjustedTableHeight : 0
        heightConstraint?.constant = totalHeight

        if isOpen {
            tableContainer.alpha = 0
            tableContainer.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)

            UIView.animate(withDuration: 0.6,
                           delay: 0,
                           usingSpringWithDamping: 0.95,
                           initialSpringVelocity: 0.2,
                           options: [.curveEaseInOut],
                           animations: {
                self.tableContainer.alpha = 1
                self.arrowImageView.transform = CGAffineTransform(rotationAngle: .pi)
                self.tableContainer.transform = .identity
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveEaseInOut],
                           animations: {
                self.tableContainer.alpha = 0
                self.arrowImageView.transform = .identity
                self.layoutIfNeeded()
            }, completion: { _ in
                self.tableContainer.isHidden = true
            })
        }

        if let scrollView = self.findSuperview(ofType: UIScrollView.self) {
            scrollView.setNeedsLayout()
            scrollView.layoutIfNeeded()
        }

        if let listVC = self.findViewController() {
            listVC.view.setNeedsLayout()
            listVC.view.layoutIfNeeded()
        }
    }

    func updateItems(_ newItems: [String]) {
        items = newItems
        tableView.reloadData()

        let tableContentHeight = CGFloat(items.count) * rowHeight
        let adjustedTableHeight = min(tableContentHeight, maxTableHeight)
        tableHeightConstraint?.constant = isOpen ? adjustedTableHeight : 0

        if isOpen {
            heightConstraint?.constant = closedHeight + adjustedTableHeight
        }
    }

    func clearSelection() {
        selectedItem = nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = AppColor.Text.placeHolder
        cell.backgroundColor = .white
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = items[indexPath.row]
        delegate?.locationPickerView(self, didSelectItem: items[indexPath.row])
        toggleTableView()
    }
}

@available(iOS 17.0, *)
#Preview {
    LocationPickerView(items: ["Koh Phangan", "Koh Samui"], placeholder: "Выберите город")
}
