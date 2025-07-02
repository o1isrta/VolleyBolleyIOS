import UIKit

class OrangeButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(AppColor.Text.inverted, for: .normal)
        backgroundColor = AppColor.Background.actionButtonDefault
        layer.cornerRadius = 16
        titleLabel?.font = AppFont.ActayWide.bold(size: 16)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
