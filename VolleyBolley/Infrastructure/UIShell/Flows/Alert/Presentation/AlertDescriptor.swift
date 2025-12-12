//
//  AlertDescriptor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

struct AlertDescriptor {
    let id: AlertID
    let kind: AlertKind
    let title: String?
    let message: String
    let bullets: [String]?
    let messageAlignment: AlertTextAlignment
    let actions: [AlertActionDescriptor]
    let presentationPolicy: AlertPresentationPolicy

    init(
        id: AlertID,
        kind: AlertKind,
        title: String? = nil,
        message: String,
        bullets: [String]? = nil,
        messageAlignment: AlertTextAlignment = .center,
        actions: [AlertActionDescriptor],
        presentationPolicy: AlertPresentationPolicy
    ) {
        self.id = id
        self.kind = kind
        self.title = title
        self.message = message
        self.bullets = bullets
        self.messageAlignment = messageAlignment
        self.actions = actions
        self.presentationPolicy = presentationPolicy
    }
}
