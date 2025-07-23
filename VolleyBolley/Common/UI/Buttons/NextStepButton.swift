//
//  NextStepButton.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import UIKit

/// Создание кнопки перехода к следующему окну:
/// title - заголовок;
/// isActive - состояние кнопки
final class NextStepButton: UIButton {
    
    private var isActive: Bool = false {
        didSet { updateAppearance() }
    }
    
    init(title: String = String(localized: "NEXT STEP"), isActive: Bool = false) {
        super.init(frame: .zero)
        setup(title: title)
        setActive(isActive)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func setActive(_ active: Bool) {
        isActive = active
    }
    
    private func setup(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = AppFont.ActayWide.bold(size: 16)
        layer.cornerRadius = 16
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func updateAppearance() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            if isActive {
                backgroundColor = AppColor.Background.actionButtonDefault
                setTitleColor(AppColor.Text.inverted, for: .normal)
                isEnabled = true
            } else {
                backgroundColor = AppColor.Background.actionButtonDisabled
                setTitleColor(AppColor.Text.primary, for: .normal)
                isEnabled = false
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    NextStepButton(title: "Test1234567", isActive: true)
}
