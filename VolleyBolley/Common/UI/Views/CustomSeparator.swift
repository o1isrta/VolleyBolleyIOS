import UIKit

class CustomSeparator: UIView {
    
    /*
     Разделитель для случаев когда нет смысла
     использовать коллекции
     */
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = AppColor.Border.separator
        self.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

