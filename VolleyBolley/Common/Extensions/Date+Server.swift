//
//  Date+Server.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 22.07.2025.
//

import Foundation

extension Date {

    var toServerDateString: String {
        AppDateFormatters.serverDateOnly.string(from: self)
    }
}
