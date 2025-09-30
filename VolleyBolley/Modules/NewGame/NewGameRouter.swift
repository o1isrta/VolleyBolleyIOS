//
//  NewGameRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 25.07.2025.
//

import UIKit

final class NewGameRouter: NewGameRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func routeToMain(with data: NewGameData?) {
        let tabBar = MainTabBarController()
        viewController?.present(tabBar, animated: true)
    }
    
    func showDatePicker(from: UIViewController?) {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        
        let alert = UIAlertController(title: "Select Date", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(picker)
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor),
            picker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            picker.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            (from as? NewGameView)?.presenter?.didConfirmDate(picker.date)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        from?.present(alert, animated: true)
    }
    
    func showPlacePicker(from: UIViewController?) {
        let alert = UIAlertController(title: "Choose Place", message: nil, preferredStyle: .actionSheet)
        ["Beach", "Park", "Stadium"].forEach { place in
            alert.addAction(UIAlertAction(title: place, style: .default, handler: { _ in
                (from as? NewGameView)?.presenter?.didConfirmPlace(place)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        from?.present(alert, animated: true)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
