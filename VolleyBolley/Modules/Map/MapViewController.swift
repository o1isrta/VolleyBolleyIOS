//
//  MapViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController, MapViewProtocol {
    
    // MARK: - Public Properties
    
    var router: MapRouterProtocol?
    var listView: UIView?
    
    // MARK: - Private Properties
    
    private let mapView = MKMapView()
    private let segmentedControl = CustomSegmentedControl(type: .map)
    private let bottomView = CourtBottomView()
    private let popupView = CourtDetailsPopupView()
    private var popupBottomConstraint: NSLayoutConstraint?
    
    private let presenter = MapPresenter()
    private let interactor = MapInteractor()
    private let locationManager = CLLocationManager()
    private var courts: [CourtModel] = []
    private var nearestCourt: CourtModel?
    private var selectedCourt: CourtModel?
    private var listVC: CourtListViewController?
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.interactor = interactor
        
        setupUI()
        setupMap()
        setupLocation()
        setupActions()
    }
    
    func showCourts(_ courts: [CourtModel], nearest: CourtModel?) {
        self.courts = courts
        nearestCourt = nearest
        selectedCourt = nearest
        
        // Update ListViewController with new courts
        if let listVC = listVC {
            // Recreate ListViewController with new courts
            listVC.removeFromParent()
            listVC.view.removeFromSuperview()
            let newListVC = CourtListViewController(courts: courts, selected: nearest)
            self.listVC = newListVC
            
            // Re-add to view hierarchy
            addChild(newListVC)
            newListVC.view.translatesAutoresizingMaskIntoConstraints = false// TODO
            view.addSubview(newListVC.view)
            NSLayoutConstraint.activate([
                newListVC.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
                newListVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                newListVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                newListVC.view.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -8)
            ])
            newListVC.didMove(toParent: self)
            newListVC.view.isHidden = true
            listView = newListVC.view
        }
        
        updateAnnotations(for: courts)
        
        if let nearest {
            let region = MKCoordinateRegion(center: nearest.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: true)
            bottomView.configure(with: nearest, isNearest: true)
        } else if let first = courts.first {
            nearestCourt = first
            selectedCourt = first
            let region = MKCoordinateRegion(center: first.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: true)
            bottomView.configure(with: first, isNearest: false)
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        presenter.viewDidLoad(userLocation: locations.first)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presenter.viewDidLoad(userLocation: nil)
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let identifier = "CourtAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        if
            let nearest = nearestCourt,
            annotation.coordinate.latitude == nearest.coordinate.latitude
            && annotation.coordinate.longitude == nearest.coordinate.longitude
        {
            annotationView?.markerTintColor = .systemGreen
            annotationView?.glyphText = "★"
        } else {
            annotationView?.markerTintColor = .systemBlue
            annotationView?.glyphText = nil
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }

        if let court = courts.first(where: { $0.coordinate.latitude == annotation.coordinate.latitude && $0.coordinate.longitude == annotation.coordinate.longitude }) {
            selectedCourt = court
            bottomView.configure(with: court, isNearest: isNearestCourt(court))
        }
    }
}

// MARK: - Private Methods

private extension MapViewController {
    
    func setupMap() {
        mapView.delegate = self
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func setupActions() {
        bottomView.detailsButton.addTarget(self, action: #selector(showDetailsPopup), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideDetailsPopup))
        popupView.addGestureRecognizer(tapGesture)
        
        segmentedControl.segmentChanged = { [weak self] selectedIndex in
            self?.segmentChanged()
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white// TODO
        mapView.translatesAutoresizingMaskIntoConstraints = false// TODO
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mapView)
        view.addSubview(segmentedControl)
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 200),
            segmentedControl.heightAnchor.constraint(equalToConstant: 36),
            
            mapView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            bottomView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        // Добавляем popupView
        popupView.translatesAutoresizingMaskIntoConstraints = false// TODO
        view.addSubview(popupView)
        popupBottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        
        if let popupBottomConstraint {
            NSLayoutConstraint.activate([popupBottomConstraint])
        }
        
        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            popupView.heightAnchor.constraint(equalToConstant: 400)
        ])
        popupView.isHidden = true// TODO
        
        // Добавляем listVC.view, но скрываем по умолчанию
        if listVC == nil {
            listVC = CourtListViewController(courts: courts, selected: nearestCourt)
        }
        if let listVC = listVC {
            addChild(listVC)
            listVC.view.translatesAutoresizingMaskIntoConstraints = false// TODO
            view.addSubview(listVC.view)
            NSLayoutConstraint.activate([
                listVC.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
                listVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                listVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                listVC.view.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -8)
            ])
            listVC.didMove(toParent: self)
            listVC.view.isHidden = true// TODO
            listView = listVC.view
        }
    }
    
    func updateAnnotations(for courts: [CourtModel]) {
        mapView.removeAnnotations(mapView.annotations)
        
        for court in courts {
            let annotation = MKPointAnnotation()
            annotation.title = court.name
            annotation.subtitle = court.shortDescription
            annotation.coordinate = court.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    func segmentChanged() {
        let showList = segmentedControl.selectedSegmentIndex == 1
        if showList {
            router?.showList(from: self, courts: courts, selected: nearestCourt)
        }
        mapView.isHidden = showList
        listView?.isHidden = !showList
        bottomView.isHidden = showList
        popupView.isHidden = true
    }
    
    func isNearestCourt(_ court: CourtModel) -> Bool {
        court == nearestCourt
    }
    
    @objc func showDetailsPopup() {
        guard let court = selectedCourt else { return }
        popupView.configure(with: court)
        popupView.isHidden = false
        print("show Details")
//        UIView.animate(withDuration: 0.3) {
//            self.popupBottomConstraint?.constant = -8
//            self.view.layoutIfNeeded()
//        }
        
        self.popupView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) // начальное состояние
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: []) {
            self.popupView.transform = .identity
            self.popupView.alpha = 1
        }
//        bottomView.isHidden = true
    }
    
    @objc func hideDetailsPopup() {
        print("close Details")
        
//        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn) {
//            self.popupView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
//            self.popupView.alpha = 0
//        } completion: { _ in
//            self.popupView.isHidden = true
//        }
        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.popupView.transform = CGAffineTransform(translationX: 0, y: 20)
////                .scaledBy(x: 0.01, y: 0.01)
//            self.popupView.alpha = 0
//        }) { _ in
//            self.popupView.isHidden = true
//            self.popupView.transform = .identity
//            self.popupView.alpha = 1
//        }
        
        let originalCenter = popupView.center
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: []) {
            self.popupView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY + 100)
            self.popupView.transform = CGAffineTransform(translationX: 0, y: 20)
            self.popupView.alpha = 0
        } completion: { _ in
            self.popupView.isHidden = true
            // При необходимости восстановить:
            self.popupView.center = originalCenter
            self.popupView.transform = .identity
            self.popupView.alpha = 1
        }
        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.popupBottomConstraint?.constant = -8
//            self.view.layoutIfNeeded()
//        }) { _ in
//            self.popupView.isHidden = true
////            self.bottomView.isHidden = false
//        }
    }
}
