//
//  FirebaseAuthServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.10.2025.
//

import Foundation

protocol FirebaseAuthServiceProtocol {
    func signInWithGoogle(idToken: String, accessToken: String) async throws -> String
}
