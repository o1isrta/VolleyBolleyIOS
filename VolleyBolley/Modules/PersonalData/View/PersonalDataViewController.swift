//
//  PersonalDataViewController.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

protocol PersonalDataViewProtocol: AnyObject {

}

final class PersonalDataViewController: BaseViewController, PersonalDataViewProtocol {

    // MARK: - Private Properties

    private let presenter: PersonalDataPresenterProtocol


    // MARK: - Initializers

    init(presenter: PersonalDataPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    // MARK: - Public Methods

}

// MARK: - Private methods

private extension PersonalDataViewController {

}
