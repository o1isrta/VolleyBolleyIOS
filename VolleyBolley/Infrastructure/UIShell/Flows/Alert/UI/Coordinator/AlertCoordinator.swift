//
//  AlertCoordinator.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import UIKit

protocol AlertCoordinatorProtocol {
    func show(_ decision: AlertDescriptor, retry: (() -> Void)?)
}

final class AlertCoordinator: AlertCoordinatorProtocol {

    // MARK: - Private Properties

    private struct PendingAlert {
        let descriptor: AlertDescriptor
        let retry: (() -> Void)?
    }

    private let rootProvider: RootViewControllerProviding
    private let router: AppRouter

    private var customActionHandlers: [AlertCustomActionID: () -> Void] = [:]

    @MainActor private var queue: [PendingAlert] = []
    @MainActor private var isPresenting = false
    private weak var presentedAlert: AlertViewController?

    // MARK: - Initializers

    init(root: RootViewControllerProviding, router: AppRouter) {
        self.rootProvider = root
        self.router = router
    }

    // MARK: - Public Methods

    func show(_ descriptor: AlertDescriptor, retry: (() -> Void)? = nil) {
        Task { @MainActor [weak self] in
            await self?.showOnMain(descriptor, retry: retry)
        }
    }

    func registerCustomHandler(
        id: AlertCustomActionID,
        handler: @escaping () -> Void
    ) {
        customActionHandlers[id] = handler
    }

    // MARK: - Private Methods

    @MainActor
    private func showOnMain(_ descriptor: AlertDescriptor, retry: (() -> Void)?) async {
        await applyPresentationPolicy(descriptor, retry: retry)
        await processQueueIfNeeded()
    }

    @MainActor
    private func processQueueIfNeeded() async {
        guard !isPresenting, let next = queue.first else { return }

        isPresenting = true
        await present(next)
    }

    @MainActor
    private func applyPresentationPolicy(_ descriptor: AlertDescriptor, retry: (() -> Void)?) async {
        let item = PendingAlert(descriptor: descriptor, retry: retry)

        switch descriptor.presentationPolicy {

        case .queue:
            queue.append(item)

        case .ignoreIfPresentingSameKind:
            if let current = presentedAlert?.currentKind,
               current == descriptor.kind {
                return
            }
            queue.append(item)

        case .replaceCurrent:
            if presentedAlert != nil {
                dismissCurrentAlert(animated: false)
            }
            queue.append(item)
        }
    }

    @MainActor
    private func present(_ item: PendingAlert) async {
        let alertViewController = AlertViewController()
        configure(alertViewController, with: item.descriptor, retry: item.retry)

        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve

        alertViewController.onDismiss = { [weak self] in
            self?.onAlertDismissed()
        }

        presentedAlert = alertViewController

        rootProvider.rootViewController.present(alertViewController, animated: false)
    }

    @MainActor
    private func configure(
        _ alertViewController: AlertViewController,
        with descriptor: AlertDescriptor,
        retry: (() -> Void)?
    ) {
        let actions = makeActions(
            from: descriptor.actions,
            retry: retry
        )

        let model = AlertViewModel(
            title: descriptor.title,
            message: descriptor.message,
            bullets: descriptor.bullets,
            messageAlignment: mapTextAlignment(descriptor.messageAlignment),
            actions: actions
        )

        alertViewController.configure(with: model)
        alertViewController.currentKind = descriptor.kind
    }

    @MainActor
    private func makeActions(from actions: [AlertActionDescriptor], retry: (() -> Void)?) -> [AlertActionViewModel] {

        actions.prefix(2).map { descriptor in

            let isPrimary = descriptor.style == .primary

            let widthHint: AlertActionLayoutHint = {
                switch descriptor.intent {
                case .dismiss:
                    return .compact
                default:
                    return .normal
                }
            }()

            return AlertActionViewModel(
                title: descriptor.title,
                isPrimary: isPrimary,
                maxWidthFraction: maxWidthFraction(for: widthHint),
                handler: makeHandler(for: descriptor.intent, retry: retry)
            )
        }
    }

    @MainActor
    private func makeHandler(
        for intent: AlertIntent,
        retry: (() -> Void)?
    ) -> (() -> Void)? {

        switch intent {
        case .dismiss:
            return { [weak self] in self?.dismissCurrentAlert() }

        case .retry:
            return { [weak self] in
                retry?()
                self?.dismissCurrentAlert()
            }

        case .relogin:
            return { [weak self] in
                self?.dismissCurrentAlert()
                self?.router.showAuthorization()
            }

        case .openMainApp:
            return { [weak self] in
                self?.dismissCurrentAlert()
                self?.router.showMainApp()
            }

        case .openSettings:
            return { [weak self] in
                self?.dismissCurrentAlert()
                UIApplication.shared.openSettingsURL()
            }

        case .custom(let id):
            return { [weak self] in
                defer { self?.dismissCurrentAlert() }
                self?.customActionHandlers[id]?()
            }
        }
    }

    @MainActor
    private func dismissCurrentAlert(animated: Bool = true) {
        presentedAlert?.dismiss(animated: false)
        onAlertDismissed()
    }

    @MainActor
    private func onAlertDismissed() {
        presentedAlert = nil
        isPresenting = false
        if !queue.isEmpty {
            queue.removeFirst()
        }
        Task { @MainActor in
            await processQueueIfNeeded()
        }
    }

    // MARK: - Utils

    private func maxWidthFraction(for hint: AlertActionLayoutHint) -> CGFloat? {
        switch hint {
        case .normal: return nil
        case .compact: return 0.3
        }
    }

    private func mapTextAlignment(_ alignment: AlertTextAlignment) -> NSTextAlignment {
        switch alignment {
        case .left:   return .left
        case .center: return .center
        case .right:  return .right
        }
    }
}

// MARK: - UIApplication helper

extension UIApplication {
    func openSettingsURL() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        open(url)
    }
}
