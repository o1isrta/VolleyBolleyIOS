//
//  MapRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

protocol MapRouterProtocol: AnyObject {
    func showList(from view: MapViewController, courts: [CourtModel], selected: CourtModel?)
}

final class MapRouter: MapRouterProtocol {
    
    // MARK: - Private Properties
    
    private weak var listVC: CourtListViewController?
    
    // MARK: - Private Methods
    
    func showList(from view: MapViewController, courts: [CourtModel], selected: CourtModel?) {
        let listVC = CourtListViewController(courts: courts, selected: selected)
        view.addChild(listVC)
        listVC.view.frame = view.view.bounds
        view.view.addSubview(listVC.view)
        listVC.didMove(toParent: view)
        listVC.view.isHidden = false
        self.listVC = listVC
        view.listView = listVC.view
    }
}
