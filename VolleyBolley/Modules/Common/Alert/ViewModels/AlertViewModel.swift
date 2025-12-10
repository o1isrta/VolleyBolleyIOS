//
//  AlertViewModel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import UIKit

struct AlertViewModel {
    let title: String?
    let message: String
    let bullets: [String]?
    let messageAlignment: NSTextAlignment
    let actions: [AlertActionViewModel]

    init(
        title: String? = nil,
        message: String,
        bullets: [String]?,
        messageAlignment: NSTextAlignment,
        actions: [AlertActionViewModel]
    ) {
        self.title = title
        self.message = message
        self.bullets = bullets
        self.messageAlignment = messageAlignment
        self.actions = Array(actions.prefix(2))
    }
}
