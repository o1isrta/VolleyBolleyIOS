//
//  TimePickerButton.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 05.08.2025.
//

import UIKit

/// Кнопка для выбора и отображения времени.
/// Отображает время в формате "часы:минуты AM/PM".
final class TimePickerButton: UIButton {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let stackSpacing: CGFloat = 4
    }
    
    // MARK: - Public Properties
    
    /// Размер кнопки для автоматического layout
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 89, height: 45)
    }
    
    // MARK: - Private Properties
    
    /// Лейбл для отображения времени
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 16)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Лейбл для отображения периода дня ("AM"/"PM")
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 14)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Стек для размещения лейблов времени и периода горизонтально
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeLabel, periodLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.stackSpacing
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    /// Фон с эффектом glassmorphism
    private lazy var glassView: GlassmorphismView = {
        let view = GlassmorphismView()
        view.cornerRadius = Constants.cornerRadius
        view.innerShadowRadius = 0
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Текущее выбранное время, отображаемое на кнопке
    private(set) var date: Date? {
        didSet {
            updateLabel()
        }
    }
    
    // MARK: - Initializers
    
    /// Инициализатор кнопки с опциональной датой
    /// - Parameter date: дата, которая будет отображена. Если nil — отображается заглушка ("_:__").
    init() {
        super.init(frame: .zero)
        setup()
        updateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    /// Настраивает иерархию вью и констрейнты
    private func setup() {
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        
        [glassView, labelStack].forEach {
            addSubview($0)
        }
        sendSubviewToBack(glassView)
        
        NSLayoutConstraint.activate([
            glassView.topAnchor.constraint(equalTo: topAnchor),
            glassView.bottomAnchor.constraint(equalTo: bottomAnchor),
            glassView.leadingAnchor.constraint(equalTo: leadingAnchor),
            glassView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    /// Форматирует и обновляет текст в метках timeLabel и periodLabel в зависимости от значения date
    private func updateLabel() {
        guard let date else {
            timeLabel.text = "_:__"
            periodLabel.text = "PM"
            return
        }
        
        let fullTime = AppDateFormatters.time12Hour.string(from: date)
        let components = fullTime.components(separatedBy: " ")
        timeLabel.text = components.first ?? "_:__"
        periodLabel.text = components.last ?? "PM"
    }
    
    /// Обработчик нажатия на кнопку
    @objc private func buttonTapped() {
        showTimePicker()
    }
    
    /// Показвает alert с системным date picker
    private func showTimePicker() {
        guard let topController = topMostController() else { return
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "en_US_POSIX")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.date = date ?? Date()
        
        alert.view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -8),
            datePicker.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -44)
        ])
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { [weak self] _ in
            self?.date = datePicker.date
        }))
        
        topController.present(alert, animated: true)
    }
    
    /// Возвращает верхний контроллер в текущем окне приложения
    private func topMostController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
              var topController = keyWindow.rootViewController else {
            return nil
        }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    
}

// MARK: - Preview

#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
    ZStack {
        Color(uiColor: AppColor.Background.screen)
            .ignoresSafeArea()
        UIViewRepresentableTimePickerButton()
            .frame(width: 89, height: 45)
    }
}

struct UIViewRepresentableTimePickerButton: UIViewRepresentable {
    
    func makeUIView(context: Context) -> TimePickerButton {
        let button = TimePickerButton()
        return button
    }
    
    func updateUIView(_ uiView: TimePickerButton, context: Context) {}
}
#endif
