//
//  String+ToDate.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 22.07.2025.
//

import Foundation

extension String {

    var asServerDate: Date? {
        DateFormatters.serverDateOnly.date(from: self)
    }

    var asUIDate: Date? {
        DateFormatters.uiDateOnly.date(from: self)
    }
}
