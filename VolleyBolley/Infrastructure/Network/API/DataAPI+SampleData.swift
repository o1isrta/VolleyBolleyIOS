//
//  DataAPI+SampleData.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 22.09.2025.
//

#if DEBUG
import Foundation

extension DataAPI {

    var sampleData: Data {
        switch self {
        case .googleAuth, .getCountryList, .getCurrentUser, .searchCourts,
                .invitePlayers, .updateAvatar, .updatePlayerProfile, .deletePlayer:

            return Data()
        case .getCourts:
            guard
                let url = Bundle.main.url(
                    forResource: "get_courts_sample",
                    withExtension: "json"
                ),
                let data = try? Data(contentsOf: url)
            else { return Data() }

            return data
        }
    }
}
#endif
