//
//  NetworkDIProtocols.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

protocol ProviderInitializable {
    associatedtype ProviderType
    init(provider: ProviderType)
}

protocol ServiceInitializable {
    associatedtype ServiceType
    init(service: ServiceType)
}
