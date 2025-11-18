//
//  NetworkServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.11.2025.
//

protocol NetworkServiceProtocol {
    func googleAuth(idToken: String) async throws -> PlayerSessionDTO
}
