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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Лейбл для отображения периода дня ("AM"/"PM")
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Стек для размещения лейблов времени и периода горизонтально
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeLabel, periodLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.stackSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    /// Фон с эффектом glassmorphism
    private lazy var glassView: GlassmorphismView = {
        let view = GlassmorphismView()
        view.cornerRadius = Constants.cornerRadius
        view.innerShadowRadius = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Текущее выбранное время, отображаемое на кнопке
    private var date: Date? {
        didSet {
            updateLabel()
        }
    }
    
    // MARK: - Initializers
    
    /// Инициализатор кнопки с опциональной датой
    /// - Parameter date: дата, которая будет отображена. Если nil — отображается заглушка ("_:__").
    init(date: Date? = nil) {
        super.init(frame: .zero)
        self.date = date
        setup()
        updateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    /// Обновляет отображаемое время на кнопке
    /// - Parameter date: новая дата для отображения.
    func setDate(_ date: Date) {
        self.date = date
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
    
}

// MARK: - Preview

#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
    ZStack {
        Color(uiColor: AppColor.Background.screen)
            .ignoresSafeArea()
        HStack(spacing: 16) {
            UIViewRepresentableTimePickerButton(date: Date())
                .frame(width: 89, height: 45)
            UIViewRepresentableTimePickerButton()
                .frame(width: 89, height: 45)
        }
    }
}

struct UIViewRepresentableTimePickerButton: UIViewRepresentable {
    let date: Date?
    
    init(date: Date? = nil) {
        self.date = date
    }
    
    func makeUIView(context: Context) -> TimePickerButton {
        let button = TimePickerButton(date: date)
        return button
    }
    
    func updateUIView(_ uiView: TimePickerButton, context: Context) {}
}
#endif
