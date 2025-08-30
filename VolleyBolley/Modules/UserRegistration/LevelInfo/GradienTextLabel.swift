//
//  GradientLabel.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 25.08.2025.
//
import UIKit

class GradientTextLabel: UILabel {
    var gradientColors: [UIColor] = [.systemGreen, .systemYellow] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawText(in rect: CGRect) {
        if let gradientColor = createGradientColor(in: rect) {
            self.textColor = gradientColor
        }
        super.drawText(in: rect)
    }
    
    private func createGradientColor(in rect: CGRect) -> UIColor? {
        let size = rect.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map { $0.cgColor } as CFArray
        let locations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations) else {
            return nil
        }
        
        let startPoint = CGPoint(x: size.width / 2, y: 0)
        let endPoint = CGPoint(x: size.width / 2, y: size.height)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        return UIColor(patternImage: UIImage(cgImage: cgImage))
    }
}
