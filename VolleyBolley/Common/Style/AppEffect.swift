//
//  AppEffect.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation


/// `AppEffect` provides factory methods for creating and configuring reusable effects-based UI components used throughout the app.
///
/// - Note: All methods return configured views for use in the UI layer.
enum AppEffect {

    static func glass() -> GlassmorphismView {
        let view = GlassmorphismView()
        view.isUserInteractionEnabled = false
        return view
    }

    static func glassHightLighted() -> GlassmorphismView {
        let view = GlassmorphismView()
        view.isUserInteractionEnabled = false
        view.theme = .dark
        return view
    }
}
