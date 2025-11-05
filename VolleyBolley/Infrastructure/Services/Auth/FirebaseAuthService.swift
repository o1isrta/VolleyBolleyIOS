//
//  FirebaseAuthService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.10.2025.
//

import FirebaseAuth

final class FirebaseAuthService: FirebaseAuthServiceProtocol {

    func signInWithGoogle(idToken: String, accessToken: String) async throws -> String {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        let authResult = try await Auth.auth().signIn(with: credential)
        return try await authResult.user.getIDToken()
    }
}
