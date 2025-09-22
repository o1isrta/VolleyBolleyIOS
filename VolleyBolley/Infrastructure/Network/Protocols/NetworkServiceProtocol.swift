//
//  NetworkServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.09.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCourts() async throws -> [CourtDTO]

    func googleAuth(
        code: String,
        completion: @escaping (Result<GoogleAuthResponse, Error>) -> Void
    )
    func getCountryList(completion: @escaping (Result<CountryListResponse, Error>) -> Void)
//    func searchCourts(
//        query: String,
//        completion: @escaping (Result<Court, Error>) -> Void
//    )
    func invitePlayers(
        gameID: Int,
        playerIDs: [Int],
        completion: @escaping (Result<InvitePlayersResponse, Error>) -> Void
    )
    func updateAvatar(
        avatar: String?,
        completion: @escaping (Result<UpdateAvatarResponse, Error>) -> Void
    )
    func updatePlayerProfile(
        with newData: PlayerDTO,
        completion: @escaping (Result<Void, Error>) -> Void
    )
    func deletePlayer(completion: @escaping (Result<Void, Error>) -> Void)
}
