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
        let gradientLayer = CALayer.getGradientLayer(with: colors)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        gradientLayer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
