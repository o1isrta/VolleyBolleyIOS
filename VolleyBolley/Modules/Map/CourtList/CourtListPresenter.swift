//
//  CourtListPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import Foundation
import CoreLocation

protocol CourtListPresenterProtocol: AnyObject {
    func viewDidLoad(userLocation: CLLocation?)
    func updateDistancesForCourts(_ courts: [CourtModel], userLocation: CLLocation?)
}

protocol CourtListViewProtocol: AnyObject {
    func showCourts(_ courts: [(court: CourtModel, distance: Double)])
}

class CourtListPresenter: CourtListPresenterProtocol {
    
    // MARK: - Public Methods
    
    weak var view: CourtListViewProtocol?
    var interactor: CourtListInteractorProtocol?
    
    // MARK: - Private Methods
    
    func viewDidLoad(userLocation: CLLocation?) {
        interactor?.fetchCourtsWithDistance(userLocation: userLocation) { [weak self] courtsWithDistance in
            self?.view?.showCourts(courtsWithDistance)
        }
    }
    
    func updateDistancesForCourts(_ courts: [CourtModel], userLocation: CLLocation?) {
        interactor?.calculateDistancesForCourts(courts, userLocation: userLocation) { [weak self] courtsWithDistance in
            self?.view?.showCourts(courtsWithDistance)
        }
    }
}
