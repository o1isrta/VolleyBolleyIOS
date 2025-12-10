//
//  AlertActionDescriptor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 08.12.2025.
//

struct AlertActionDescriptor {
    let intent: AlertIntent
    let title: String
    let style: AlertActionStyle
}

enum AlertActionStyle {
    case primary
    case secondary
}
