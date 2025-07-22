//
//  Date+Format.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 22.07.2025.
//

import Foundation

extension Date {

    var toServerDateString: String {
        DateFormatters.serverDateOnly.string(from: self)
    }

    var toUIDateString: String {
        DateFormatters.uiDateOnly.string(from: self)
    }
}
