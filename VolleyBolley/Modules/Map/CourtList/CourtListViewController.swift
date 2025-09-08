//
//  CourtListViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import UIKit

final class CourtListViewController: UIViewController {

	// MARK: - Private Properties

	private let presenter = CourtListPresenter()
	private let interactor: CourtListInteractor
	private let locationManager = CLLocationManager()

	private var courtList: [(court: CourtModel, distance: Double)] = [] {
		didSet {
			updateFilteredCourts()
		}
	}
	private var filteredCourts: [(court: CourtModel, distance: Double)] = []

	private var selectedCourt: CourtModel?
	private var initialCourts: [CourtModel] = []
	private var expandedIndex: Int?

	private var tableViewHeightConstraint: NSLayoutConstraint?
	private var tableViewContentSizeObserver: NSKeyValueObservation?
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.dataSource = self
		tableView.delegate = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 80
		tableView.showsVerticalScrollIndicator = false
		tableView.register(CourtTableViewCell.self, forCellReuseIdentifier: CourtTableViewCell.reuseIdentifier)
		tableView.register(CourtDetailsCell.self, forCellReuseIdentifier: CourtDetailsCell.reuseIdentifier)
		return tableView
	}()

	private lazy var searchField = GradientSearchField(type: .search)
	private lazy var glassmorphismView = GlassmorphismView()

	// MARK: - Initializers

	init(courts: [CourtModel], selected: CourtModel?) {
		self.interactor = CourtListInteractor(courts: courts, distanceService: DistanceService())
		super.init(nibName: nil, bundle: nil)
		self.selectedCourt = selected
		self.initialCourts = courts
		// Store initial courts but don't set distances yet
		self.courtList = courts.map { ($0, -1) }
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.view = self
		presenter.interactor = interactor
		setupUI()
		setupLocation()
		setupSearchTextField()
		setupTableViewContentSizeObserver()
	}
}

extension CourtListViewController: CourtListViewProtocol {

	func showCourts(_ courts: [(court: CourtModel, distance: Double)]) {
		// TODO: -
		print("📱 ListViewController: Updating courts with distances")
		for (index, court) in courtList.enumerated() {
			print("📱 Court \(index + 1): '\(court.court.location.courtName)' - \(court.distance) km")
		}
		courtList = courts
		tableView.reloadData()
	}
}

// MARK: - UITableViewDelegate

extension CourtListViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let realIndex = isRealIndex(row: indexPath.row)
		expandedIndex = expandedIndex == realIndex ? nil : realIndex
		tableView.reloadData()
	}

	private func isRealIndex(row: Int) -> Int {
		let realIndex = expandedIndex != nil && row > expandedIndex ?? 0
			? row - 1
			: row

		return realIndex
	}
}

// MARK: - UITableViewDataSource

extension CourtListViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		getRowsCount()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// no courts found
		if filteredCourts.count == 0 {
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: CourtTableViewCell.reuseIdentifier,
				for: indexPath
			) as? CourtTableViewCell {
				cell.configureAsNoCourts()
				return cell
			}
		}
		// cell with court details
		if let expanded = expandedIndex, indexPath.row == expanded + 1 {
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: CourtDetailsCell.reuseIdentifier,
				for: indexPath
			) as? CourtDetailsCell {
				let court = filteredCourts[expanded].court
				let isLast = indexPath.row == getRowsCount() - 1
				cell.configure(with: court, isLast: isLast)
				return cell
			}
		}
		// cell with court info
		if let cell = tableView.dequeueReusableCell(
			withIdentifier: CourtTableViewCell.reuseIdentifier,
			for: indexPath
		) as? CourtTableViewCell {
			let realIndex = isRealIndex(row: indexPath.row)
			if filteredCourts.indices.contains(realIndex) {
				let item = filteredCourts[realIndex]
				let isLast = indexPath.row == getRowsCount() - 1 || indexPath.row == expandedIndex ? true : false
				cell.configure(with: item.court, distance: item.distance, isLast: isLast)
				return cell
			}
		}

		return UITableViewCell()
	}
}

// MARK: - CLLocationManagerDelegate

extension CourtListViewController: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print("📍 LocationManager: Got location update")// TODO
		if let location = locations.first {
			print("📍 Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
		}
		// Use initial courts for distance calculation
		presenter.updateDistancesForCourts(initialCourts, userLocation: locations.first)
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("❌ LocationManager: Failed to get location - \(error.localizedDescription)")
		// Detailed error handling
		if let clError = error as? CLError {
			switch clError.code {
			case .denied:
				print("❌ Пользователь запретил доступ к геолокации")
				// For testing we use a test location (New York)
				let testLocation = CLLocation(latitude: 40.7589, longitude: -73.9851)
				print("📍 Используем тестовую локацию: \(testLocation.coordinate.latitude), \(testLocation.coordinate.longitude)")
				presenter.updateDistancesForCourts(initialCourts, userLocation: testLocation)
				return
			case .locationUnknown:
				print("❌ Локация временно недоступна")
			case .network:
				print("❌ Проблема с сетью")
			default:
				print("❌ Ошибка геолокации: \(clError.localizedDescription)")
			}
		}
		// Use initial courts for distance calculation
		presenter.updateDistancesForCourts(initialCourts, userLocation: nil)
	}

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		print("📍 LocationManager: Authorization status changed to \(status.rawValue)")
		switch status {
		case .authorizedWhenInUse, .authorizedAlways:
			print("📍 Разрешение получено, запрашиваем локацию...")
			locationManager.requestLocation()
		case .denied, .restricted:
			print("❌ Доступ к геолокации запрещен")
			presenter.updateDistancesForCourts(initialCourts, userLocation: nil)
		case .notDetermined:
			print("📍 Статус авторизации не определен")
		@unknown default:
			print("❌ Неизвестный статус авторизации")
			presenter.updateDistancesForCourts(initialCourts, userLocation: nil)
		}
	}
}

// MARK: - Private Methods

private extension CourtListViewController {

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
			let maxHeight = UIScreen.main.bounds.height - 200
			let newHeight = min(newSize.height, maxHeight)
			self.tableViewHeightConstraint?.constant = newHeight
		}
	}

	func getRowsCount() -> Int {
		if filteredCourts.count == 0 {
			return 1
		}

		return filteredCourts.count + (expandedIndex != nil ? 1 : 0)
	}

	func setupUI() {
		view.backgroundColor = .clear
		view.addSubviews(glassmorphismView, searchField, tableView)

		let mainIndent: CGFloat = 20

		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
			glassmorphismView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			glassmorphismView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
			glassmorphismView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),

			searchField.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: mainIndent),
			searchField.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainIndent),
			searchField.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor, constant: -mainIndent),

			tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 4),
			tableView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainIndent),
			tableView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor, constant: -mainIndent)
		])

		tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
		tableViewHeightConstraint?.isActive = true
	}

	func setupLocation() {
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest

		// Проверяем текущий статус авторизации
		switch locationManager.authorizationStatus {
		case .notDetermined:
			print("📍 Запрашиваем разрешение на геолокацию...")
			locationManager.requestWhenInUseAuthorization()
		case .authorizedWhenInUse, .authorizedAlways:
			print("📍 Разрешение получено, запрашиваем локацию...")
			locationManager.requestLocation()
		case .denied, .restricted:
			print("❌ Доступ к геолокации запрещен пользователем")
			// Показываем корты без расстояний
			presenter.updateDistancesForCourts(initialCourts, userLocation: nil)
		@unknown default:
			print("❌ Неизвестный статус авторизации геолокации")
			presenter.updateDistancesForCourts(initialCourts, userLocation: nil)
		}
	}

	func setupSearchTextField() {
		searchField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
	}

	@objc func searchTextChanged() {
		updateFilteredCourts()
	}

	func updateFilteredCourts() {
		let filterText = (searchField.text ?? "").lowercased()
		filteredCourts = courtList.filter { court in
			return filterText.isEmpty || court.court.location.courtName.localizedCaseInsensitiveContains(filterText)
		}
		tableView.reloadData()
	}
}
