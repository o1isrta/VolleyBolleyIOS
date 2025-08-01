//
//  AppButtonConfig.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.07.2025.
//

import UIKit

protocol AppButtonConfig {
    var title: String? { get }
    var image: UIImage? { get }
    var actionImage: UIImage? { get }
    var actionTitle: String? { get }
    func style(for state: UIControl.State) -> AppButtonStyle?
}
