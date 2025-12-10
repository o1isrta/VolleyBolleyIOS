//
//  UIShellProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.12.2025.
//

protocol UIShellProtocol {
    func showAlert(_ error: DomainError, retry: (() -> Void)?)
    func showAlert(_ error: DomainError)

    func showLoader()
    func hideLoader()
}
