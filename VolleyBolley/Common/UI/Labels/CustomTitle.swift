import UIKit

///  Создание типового заголовка:
/// text - текст заголовка,
/// isLarge - выбор величины заголовка (24 или 20 шрифт)
class CustomTitle: UILabel {

    init(text: String, isLarge: Bool = false) {
        super.init(frame: .zero)

        let fontSize: CGFloat = isLarge ? 24 : 20
        self.text = text
        self.font = AppFont.ActayWide.bold(size: fontSize)
        self.textColor = AppColor.Text.primary
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
