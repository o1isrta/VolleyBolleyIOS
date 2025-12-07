//
//  AlertModel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import UIKit

struct AlertModel {
    let title: String?
    let message: String
    let bullets: [String]?
    let messageAlignment: NSTextAlignment
    let actions: [AlertActionModel]

    init(
        title: String? = nil,
        message: String,
        bullets: [String]?,
        messageAlignment: NSTextAlignment,
        actions: [AlertActionModel]
    ) {
        self.title = title
        self.message = message
        self.bullets = bullets
        self.messageAlignment = messageAlignment
        self.actions = Array(actions.prefix(2))
    }
}
