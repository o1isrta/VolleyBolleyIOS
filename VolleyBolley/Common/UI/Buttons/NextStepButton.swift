import UIKit

final class NextStepButton: UIButton {
    
    // У кнопки есть статус "активна" и "неактивна"
    enum State {
        case active
        case inactive
    }
    
    // Начальное состояние параметра - неактивна
    private var currentState: State = .inactive {
        didSet {
            updateAppearance()
        }
    }
    
    // Инициализация кнопки с тайтлом и статус активности
    init(title: String = "NEXT STEP", initialState: State = .inactive) {
        super.init(frame: .zero)
        setupButton(title: title)
        setState(initialState)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton(title: "NEXT STEP")
        setState(.inactive)
    }
    
    func setState(_ state: State) {
        currentState = state
    }
    
    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
    
    // Устанавливаем все параметры кнопки по умолчанию
    private func setupButton(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = AppFont.ActayWide.bold(size: 16)
        layer.cornerRadius = 16
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // Все изменения, которые происходят с кнопкой при изменении статуса
    private func updateAppearance() {
        UIView.animate(withDuration: 0.2) {
            switch self.currentState {
            case .active:
                self.backgroundColor = AppColor.Background.actionButtonDefault
                self.setTitleColor(AppColor.Text.inverted, for: .normal)
                self.isEnabled = true
            case .inactive:
                self.backgroundColor = AppColor.Background.actionButtonDisabled
                self.setTitleColor(AppColor.Text.primary, for: .normal)
                self.isEnabled = false
            }
        }
    }
}
