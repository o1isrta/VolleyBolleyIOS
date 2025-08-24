//
//  UtilityButtonStyle.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.08.2025.
//

import UIKit

struct UtilityButtonStyle {
    let imageConfig: UIImage.SymbolConfiguration

    init(
        imageConfig: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
    ) {
        self.imageConfig = imageConfig
    }
}

extension UtilityButtonStyle {
    static let small = UtilityButtonStyle(
        imageConfig: .init(pointSize: 16, weight: .medium)
    )
    static let large = UtilityButtonStyle()
}
