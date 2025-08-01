//
//  AppEffect.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

/// Эффекты такие как эффект стекла, блюры и прочие
enum AppEffect {
    static func glass() -> GlassEffectView {
        let view = GlassEffectView()
        return view
    }
}
