import UIKit

class PickButton: UIButton {
    
    private var gradientLayer: CAGradientLayer?
    private var borderGradientLayer: CAGradientLayer?
    
    init(title: String, isSelected: Bool = false) {
        super.init(frame: .zero)
        commonInit(title: title, isSelected: isSelected)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(title: "", isSelected: false)
    }
    
    private func commonInit(title: String, isSelected: Bool) {
        setTitle(title, for: .normal)
        titleLabel?.font = AppFont.Hero.regular(size: 16)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addGradientBorder()
        updateSelectionState(isSelected)
    }
    
    func updateSelectionState(_ isSelected: Bool) {
        self.isSelected = isSelected
        
        setTitleColor(isSelected ? AppColor.Text.inverted : AppColor.Text.primary, for: .normal)
        
        if isSelected {
            addGradientBackground()
        } else {
            removeGradientBackground()
            backgroundColor = .clear
        }
    }
    
    private func addGradientBackground() {
        removeGradientBackground()
        
        let gradient = createGradientLayer()
        gradient.frame = bounds
        gradient.cornerRadius = layer.cornerRadius
        
        layer.insertSublayer(gradient, at: 0)
        gradientLayer = gradient
    }
    
    private func removeGradientBackground() {
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
    }
    
    private func addGradientBorder() {
        removeGradientBorder()
        
        let borderGradient = createGradientLayer()
        borderGradient.frame = bounds
        borderGradient.cornerRadius = layer.cornerRadius
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
        let insetCornerRadius = max(layer.cornerRadius - 1, 0)
        let innerPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 1, dy: 1), cornerRadius: insetCornerRadius)
        path.append(innerPath)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        
        borderGradient.mask = maskLayer
        
        layer.addSublayer(borderGradient)
        borderGradientLayer = borderGradient
    }
    
    private func removeGradientBorder() {
        borderGradientLayer?.removeFromSuperlayer()
        borderGradientLayer = nil
    }
    
    private func createGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [AppColor.Border.gradYellow.cgColor, AppColor.Border.gradGreen.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = bounds
        borderGradientLayer?.frame = bounds
        
        if let maskLayer = borderGradientLayer?.mask as? CAShapeLayer {
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
            let insetCornerRadius = max(layer.cornerRadius - 1, 0)
            let innerPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 1, dy: 1), cornerRadius: insetCornerRadius)
            path.append(innerPath)
            maskLayer.path = path.cgPath
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.intrinsicContentSize ?? CGSize(width: 50, height: 39)
        return CGSize(width: labelSize.width + 20, height: 39)
    }
}
