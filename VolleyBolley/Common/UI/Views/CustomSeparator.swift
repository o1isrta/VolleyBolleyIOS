import UIKit

/// Разделитель для случаев когда нет смысла
/// использовать коллекции
class CustomSeparator: UIView {

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 1)
    }

    init() {
        super.init(frame: .zero)
        self.backgroundColor = AppColor.Border.separator
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
