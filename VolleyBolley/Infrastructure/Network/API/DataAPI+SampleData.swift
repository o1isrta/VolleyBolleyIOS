//
//  DataAPI+SampleData.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 24.10.2025.
//

#if DEBUG
import Foundation

extension DataAPI {

    var sampleData: Data {
        switch self {
        case .googleAuth:
            guard
                let url = Bundle.main.url(
                    forResource: "post_google_auth_sample",
                    withExtension: "json"
                ),
                let data = try? Data(contentsOf: url)
            else { return Data() }

            return data
        default:
            return Data()
        }
    }
}
#endif
