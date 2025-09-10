//
//  EditProfilePhotoRouter.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import UIKit

protocol EditProfilePhotoRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
    func navigateBack(from view: EditProfilePhotoViewControllerProtocol?)
}

final class EditProfilePhotoRouter: EditProfilePhotoRouterProtocol {

    // MARK: - Public Properties

    weak var viewController: UIViewController?

    // MARK: - Public Methods

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

    func navigateBack(from view: EditProfilePhotoViewControllerProtocol?) {
        if let viewController = viewController {
            viewController.navigationController?.popViewController(animated: true)
        } else if let view = view as? UIViewController {
            view.navigationController?.popViewController(animated: true)
        }
    }
}
