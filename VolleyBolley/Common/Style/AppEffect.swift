//
//  AppEffect.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

/// Эффекты такие как эффект стекла, блюры и прочие
enum AppEffect {

    enum BackgroundAlert {
        static let alert = semiTransparentGray
    }
}

private extension AppEffect {
    static let semiTransparentGray = UIColor(hex: "#555252", alpha: 0.3)
}
