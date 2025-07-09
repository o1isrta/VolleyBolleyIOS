//
//  MapPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import Foundation

protocol MapPresenterProtocol: AnyObject {
    func viewDidLoad(userLocation: CLLocation?)
}

protocol MapViewProtocol: AnyObject {
    func showCourts(_ courts: [CourtModel], nearest: CourtModel?)
}

final class MapPresenter: MapPresenterProtocol {
    
    // MARK: - Public Properties
    
    weak var view: MapViewProtocol?
    var interactor: MapInteractorProtocol?
    
    // MARK: - Public Methods
    
    func viewDidLoad(userLocation: CLLocation?) {
        interactor?.fetchCourts { [weak self] courts in
            var nearest: CourtModel? = nil
            if let userLocation = userLocation {
                nearest = courts.min(by: { userLocation.distance(from: CLLocation(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)) < userLocation.distance(from: CLLocation(latitude: $1.coordinate.latitude, longitude: $1.coordinate.longitude)) })
            }
            self?.view?.showCourts(courts, nearest: nearest)
        }
    }
}
