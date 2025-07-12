import UIKit

class PickButton: UIButton {
    
    /*
     Создание кнопки с градиентной заливкой от желтого к зеленому:
     title - заголовок кнопки
     isSelected - состояние нажата/не нажата
     */
    
    private var gradientLayer: CAGradientLayer?
    private var borderGradientLayer: CAGradientLayer?
    
    private let cornerRadius: CGFloat = 16
    private let borderWidth: CGFloat = 1
    
    init(title: String, isSelected: Bool = false) {
        super.init(frame: .zero)
        setup(title: title, isSelected: isSelected)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(title: "", isSelected: false)
    }
    
    private func setup(title: String, isSelected: Bool) {
        setTitle(title, for: .normal)
        titleLabel?.font = AppFont.Hero.regular(size: 16)
        
        layer.cornerRadius = cornerRadius
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
        gradient.cornerRadius = cornerRadius
        
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
        borderGradient.cornerRadius = cornerRadius
        
        let maskLayer = createBorderMask()
        borderGradient.mask = maskLayer
        
        layer.addSublayer(borderGradient)
        borderGradientLayer = borderGradient
    }
    
    private func removeGradientBorder() {
        borderGradientLayer?.removeFromSuperlayer()
        borderGradientLayer = nil
    }
    
    private func createBorderMask() -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        let innerPath = UIBezierPath(
            roundedRect: bounds.insetBy(dx: borderWidth, dy: borderWidth),
            cornerRadius: max(cornerRadius - borderWidth, 0)
        )
        path.append(innerPath)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        return maskLayer
    }
    
    private func createGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = AppGradient.greenLight.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrames()
    }
    
    private func updateGradientFrames() {
        gradientLayer?.frame = bounds
        borderGradientLayer?.frame = bounds
        
        if let maskLayer = borderGradientLayer?.mask as? CAShapeLayer {
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            let innerPath = UIBezierPath(
                roundedRect: bounds.insetBy(dx: borderWidth, dy: borderWidth),
                cornerRadius: max(cornerRadius - borderWidth, 0)
            )
            path.append(innerPath)
            maskLayer.path = path.cgPath
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.intrinsicContentSize ?? CGSize(width: 50, height: 39)
        return CGSize(width: labelSize.width + 20, height: 39)
    }
}
