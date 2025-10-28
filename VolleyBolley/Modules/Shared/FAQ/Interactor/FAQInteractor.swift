//
//  FAQInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.10.2025.
//

import Foundation

protocol FAQInteractorProtocol: AnyObject {
    func fetchFAQItems() -> [FAQItem]
}

final class FAQInteractor: FAQInteractorProtocol {

    // MARK: - Public Methods

    func fetchFAQItems() -> [FAQItem] {
        return FAQItem.allCases
    }
}
