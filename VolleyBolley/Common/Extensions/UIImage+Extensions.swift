//
//  UIImage+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.06.2025.
//

import UIKit

extension UIImage {
    
    // MARK: - gradientImage
    
    static func gradientImage(size: CGSize, with colors: [UIColor] = AppGradient.greenLight) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: size)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
