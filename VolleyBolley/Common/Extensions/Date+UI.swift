//
//  Date+UI.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 23.07.2025.
//

import Foundation

extension Date {

    func localizedIntervalString(to endDate: Date) -> String {
        AppDateFormatters.localizedInterval.string(from: self, to: endDate)
    }
}
