//
//  PersonalDataRouter.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

protocol PersonalDataRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
}

final class PersonalDataRouter: PersonalDataRouterProtocol {

    weak var viewController: UIViewController?

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }
}
