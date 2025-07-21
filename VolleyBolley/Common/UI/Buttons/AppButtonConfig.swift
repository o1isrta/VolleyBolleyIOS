//
//  AppButtonConfig.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.07.2025.
//

import UIKit

protocol AppButtonConfig {
    var supportedStates: [AppButtonVisualState] { get }
    var title: String? { get }
    var image: UIImage? { get }
    func style(for state: AppButtonVisualState) -> AppButtonStyle
}
