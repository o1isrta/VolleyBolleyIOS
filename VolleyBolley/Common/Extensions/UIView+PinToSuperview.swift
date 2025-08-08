//
//  UIView+PinToSuperview.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

extension UIView {

    /// Pins the edges of the view to its superview's edges using Auto Layout constraints.
    ///
    /// This method disables `translatesAutoresizingMaskIntoConstraints` for the view
    /// and adds constraints so that the view's top, leading, bottom, and trailing anchors
    /// are equal to the corresponding anchors of its superview, with optional insets.
    ///
    /// - Parameter insets: The amount to inset each edge from the superview. Defaults to `.zero`.
    /// - Note: If the view does not have a superview, this method prints a warning and does nothing.
    func pinToSuperviewEdges(insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else {
            assertionFailure("UIView must have a superview before calling pinToSuperviewEdges")
            return
        }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right)
        ])
    }
}
