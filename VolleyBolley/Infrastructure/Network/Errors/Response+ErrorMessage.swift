//
//  Response+ErrorMessage.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 24.09.2025.
//

import Foundation
import Moya

extension Response {

    var errorMessage: String? {
        guard
            !data.isEmpty,
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            return nil
        }

        return json["error"] as? String ?? json["message"] as? String
    }
}
