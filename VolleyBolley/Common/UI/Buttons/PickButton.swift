import UIKit

class PickButton: UIButton {
    
    init(title: String, isSelected: Bool = false) {
        super.init(frame: .zero)
        setup(title: title, isSelected: isSelected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(title: String, isSelected: Bool) {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
        translatesAutoresizingMaskIntoConstraints = false
        
        updateSelectionState(isSelected)
    }
    
    func updateSelectionState(_ isSelected: Bool) {
        self.isSelected = isSelected
        
        backgroundColor = isSelected ? .systemGreen : .clear
        setTitleColor(isSelected ? .black : .white, for: .normal)
        layer.borderWidth = isSelected ? 0 : 1
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.intrinsicContentSize ?? CGSize(width: 50, height: 39)
        return CGSize(width: labelSize.width + 20, height: 39)
    }
}
