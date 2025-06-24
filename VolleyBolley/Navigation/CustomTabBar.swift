//
//  CustomTabBar.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

class CustomTabBar: UITabBar {
    
    // MARK: - Properties

    private let shapeLayer = CAShapeLayer()
    
    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        setupRoundedCorners()
    }
    
    // MARK: - hitTest

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let defaultHitTest = super.hitTest(point, with: event)
        return defaultHitTest == nil ? nil : defaultHitTest
    }
}

private extension CustomTabBar {
    
    // MARK: - setupRoundedCorners
    
    private func setupRoundedCorners() {
        let radius: CGFloat = 32.0
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )

        shapeLayer.path = path.cgPath
        // TODO: - colors
        shapeLayer.fillColor = UIColor(hexString: "#295E6D").cgColor

        layer.insertSublayer(shapeLayer, at: 0)
    }
}
