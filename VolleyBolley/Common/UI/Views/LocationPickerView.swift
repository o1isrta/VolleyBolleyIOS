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

class LocationPickerView: UIView, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: LocationPickerViewDelegate?

    private let titleContainer = UIView()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let tableContainer = UIView()
    private let tableView = UITableView()
    private let cellIdentifier = "LocationCell"

    private var heightConstraint: NSLayoutConstraint!
    private var tableHeightConstraint: NSLayoutConstraint!
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

        // MARK: - Title Container (общая рамка вокруг UILabel и стрелки)

        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.backgroundColor = .white
        titleContainer.layer.cornerRadius = 16
        titleContainer.layer.borderWidth = 1
        titleContainer.layer.borderColor = .init(gray: 0.8, alpha: 1)
        titleContainer.clipsToBounds = true
        titleContainer.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleTableView))
        titleContainer.addGestureRecognizer(tap)

        addSubview(titleContainer)

        // Title Label (без своей рамки)
        titleLabel.text = placeholder
        titleLabel.textColor = AppColor.Text.placeholder
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //        titleLabel.backgroundColor = .white

        // Arrow
        arrowImageView.image = UIImage(systemName: "chevron.down")
        arrowImageView.tintColor = AppColor.Text.placeholder
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false

        titleContainer.addSubview(titleLabel)
        titleContainer.addSubview(arrowImageView)

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
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16)
        ])

        // MARK: - Table Container (с рамкой и радиусом)

        tableContainer.translatesAutoresizingMaskIntoConstraints = false
        tableContainer.backgroundColor = .white
        tableContainer.layer.cornerRadius = 16
        tableContainer.layer.borderWidth = 1
        tableContainer.layer.borderColor = AppColor.Border.primary.cgColor
        tableContainer.clipsToBounds = true
        tableContainer.isHidden = true
        tableContainer.alpha = 0

        addSubview(tableContainer)

        NSLayoutConstraint.activate([
            tableContainer.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 6),
            tableContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        // MARK: - Table View

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorInset = .zero

        tableContainer.addSubview(tableView)

        tableHeightConstraint = tableContainer.heightAnchor.constraint(equalToConstant: 0)
        tableHeightConstraint.isActive = true

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableContainer.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableContainer.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableContainer.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableContainer.bottomAnchor)
        ])

        // MARK: - Overall height constraint

        heightConstraint = heightAnchor.constraint(equalToConstant: closedHeight)
        heightConstraint.isActive = true
    }

    @objc func toggleTableView() {
        print("toggleTableView called. isOpen before toggle: \(isOpen)")
        print("items count: \(items.count)")

        isOpen.toggle()

        print("isOpen after toggle: \(isOpen)")

        tableContainer.isHidden = false

        let tableContentHeight = CGFloat(items.count) * rowHeight
        let adjustedTableHeight = min(tableContentHeight, maxTableHeight)
        let totalHeight = isOpen ? closedHeight + adjustedTableHeight : closedHeight

        tableHeightConstraint.constant = isOpen ? adjustedTableHeight : 0
        heightConstraint.constant = totalHeight

        print("tableHeightConstraint: \(tableHeightConstraint.constant), heightConstraint: \(heightConstraint.constant)")

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
            print("scrollView layout updated")
        }

        if let vc = self.findViewController() {
            vc.view.setNeedsLayout()
            vc.view.layoutIfNeeded()
            print("viewController layout updated")
        }
    }

    // MARK: - Public Methods

    func updateItems(_ newItems: [String]) {
        items = newItems
        tableView.reloadData()

        let tableContentHeight = CGFloat(items.count) * rowHeight
        let adjustedTableHeight = min(tableContentHeight, maxTableHeight)
        tableHeightConstraint.constant = isOpen ? adjustedTableHeight : 0

        if isOpen {
            heightConstraint.constant = closedHeight + adjustedTableHeight
        }
    }

    func clearSelection() {
        selectedItem = nil
    }

    // MARK: UITableViewDataSource / Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = AppColor.Text.placeholder
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
