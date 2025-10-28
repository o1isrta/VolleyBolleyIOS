//
//  GoogleAuthResponse.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

struct GoogleAuthResponse: Decodable {
	let accessToken: String
	let refreshToken: String
	let player: PlayerDTO
}
