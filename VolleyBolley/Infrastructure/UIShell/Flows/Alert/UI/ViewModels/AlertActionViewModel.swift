//
//  AlertActionViewModel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Foundation

struct AlertActionViewModel {
    let title: String
    let isPrimary: Bool
    /// optional: max width as fraction of stack width (0...1)
    let maxWidthFraction: CGFloat?
    let handler: (() -> Void)?
}

enum AlertActionLayoutHint {
    case normal
    case compact
}
