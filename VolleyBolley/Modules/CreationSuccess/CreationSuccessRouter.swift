//
//  CreationSuccessRouter.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 11.09.2025.
//

import UIKit

protocol CreationSuccessRouterProtocol {
    func closeScreen()
    func openShareSheet(with text: String)
}

final class CreationSuccessRouter: CreationSuccessRouterProtocol {

    // MARK: - Internal Properties

    weak var viewController: UIViewController?

    // MARK: - Initializers

    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }

    // MARK: - Internal Methods

    func closeScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func openShareSheet(with text: String) {
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        viewController?.present(activityVC, animated: true)
    }
}
