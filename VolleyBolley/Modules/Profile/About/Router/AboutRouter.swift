//
//  AboutRouter.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import UIKit

protocol AboutRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
}

final class AboutRouter: AboutRouterProtocol {
    weak var viewController: UIViewController?

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }
}

