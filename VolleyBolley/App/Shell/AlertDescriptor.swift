//
//  AlertDescriptor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import UIKit

struct AlertDescriptor {
    let title: String?
    let message: String
    let bullets: [String]?
    let messageAlignment: NSTextAlignment
    let actions: [AlertAction]

    init(
        title: String? = nil,
        message: String,
        bullets: [String]? = nil,
        messageAlignment: NSTextAlignment = .center,
        actions: [AlertAction]
    ) {
        self.title = title
        self.message = message
        self.bullets = bullets
        self.messageAlignment = messageAlignment
        self.actions = actions
    }
}
