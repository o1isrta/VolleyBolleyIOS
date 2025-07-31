import UIKit

/// Создание типового лейбла:
/// text - текст лейбла,
/// isBold - выбор толщины лейбла (16 или 14 шрифт)
class CustomLabel: UILabel {

    init(text: String, isBold: Bool = false) {
        super.init(frame: .zero)

        let fontSize: CGFloat = isBold ? 16 : 14
        self.text = text
        self.font = isBold ? AppFont.Hero.bold(size: fontSize) : AppFont.Hero.regular(size: fontSize)
        self.textColor = AppColor.Text.primary
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
