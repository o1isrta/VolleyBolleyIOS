//
//  CreationInfo.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 14.09.2025.
//

import Foundation

protocol CreationInfo {
    var courtName: String { get }
    var locationName: String { get }
    var startTime: Date { get }
    var endTime: Date { get }
    var levels: [String] { get }
    var gender: String { get }
    var pricePerPerson: String { get }
    var currency: String { get }
    var paymentAccount: String { get }
}
