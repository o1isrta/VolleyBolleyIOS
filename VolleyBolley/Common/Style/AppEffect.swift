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

    static func glass() -> GlassEffectView {
        let view = GlassEffectView()
        return view
    }
}

private extension AppEffect {
    static let semiTransparentGray = AppColor.Background.alert.withAlphaComponent(0.3)
}
