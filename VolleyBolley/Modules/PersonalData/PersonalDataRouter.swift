//
//  PersonalDataRouter.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

final class PersonalDataRouter: PersonalDataRouterProtocol {

    // MARK: - Public Properties

    weak var viewController: UIViewController?

    // MARK: - Public Methods

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

    func navigateBack(from view: PersonalDataViewProtocol?) {
        if let viewController = viewController {
            viewController.navigationController?.popViewController(animated: true)
        } else if let view = view as? UIViewController {
            view.navigationController?.popViewController(animated: true)
        }
    }
}
