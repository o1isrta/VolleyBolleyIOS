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
    private let customHeight: CGFloat = 53
    
    // MARK: - Internal Methods
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = customHeight
        return size
    }
    
    // MARK: - Public Properties
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRoundedCorners()
        adjustItemPositions()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let defaultHitTest = super.hitTest(point, with: event)
        return defaultHitTest == nil ? nil : defaultHitTest
    }
}

// MARK: - Private Methods

private extension CustomTabBar {
    
    func setupRoundedCorners() {
        let radius: CGFloat = 32.0
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = AppColor.Background.tabBar.cgColor
        
        layer.insertSublayer(shapeLayer, at: 0)
    }
    
    func adjustItemPositions() {
        guard let items = items else { return }
        
        let tabBarItemSize = CGSize(
            width: bounds.width / CGFloat(items.count),
            height: customHeight
        )
        
        for (index, item) in items.enumerated() {
            guard let itemView = item.value(forKey: "view") as? UIView else { continue }
            
            let yPosition: CGFloat = 0
            let xPosition = tabBarItemSize.width * CGFloat(index)
            
            itemView.frame = CGRect(
                x: xPosition,
                y: yPosition,
                width: tabBarItemSize.width,
                height: tabBarItemSize.height
            )
        }
    }
}
