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

    /// Базовый размер кнопки для автоматического layout.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 89, height: 45)
    }

    // MARK: - Private Properties

    /// Лейбл, отображающий время в формате "часы:минуты".
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 16)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Лейбл, отображающий период дня ("AM"/"PM").
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 14)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Горизонтальный стек для размещения лейблов времени и периода.
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeLabel, periodLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.stackSpacing
        stack.isUserInteractionEnabled = false
        return stack
    }()

    /// Подложка с эффектом glassmorphism.
    private lazy var glassView: GlassmorphismView = {
        let view = GlassmorphismView()
        view.cornerRadius = Constants.cornerRadius
        view.innerShadowRadius = 0
        view.isUserInteractionEnabled = false
        return view
    }()

    /// Текущее выбранное время.
    ///
    /// При изменении значения автоматически обновляет `timeLabel` и `periodLabel`.
    /// Может быть `nil`, если пользователь ещё не выбрал время.
    private(set) var time: Date? {
        didSet {
            updateLabel()
        }
    }

    // MARK: - Initializers

    /// Инициализатор кнопки.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    /// Настраивает иерархию представлений и констрейнты.
    private func setup() {
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true

        addSubviews(glassView, labelStack)
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

    /// Обновляет текст лейблов `timeLabel` и `periodLabel` на основе текущего времени.
    ///
    /// Если `time` равно `nil`, отображает плейсхолдер "_:__ PM".
    private func updateLabel() {
        guard let time else {
            timeLabel.text = "_:__"
            periodLabel.text = "PM"
            return
        }

        let fullTime = AppDateFormatters.time12Hour.string(from: time)
        let components = fullTime.components(separatedBy: " ")
        timeLabel.text = components.first ?? "_:__"
        periodLabel.text = components.last ?? "PM"
    }

    /// Обрабатывает нажатие на кнопку и показывает `UIDatePicker`.
    @objc private func buttonTapped() {
        showTimePicker()
    }

    /// Показывает алерт с системным `UIDatePicker` для выбора времени.
    private func showTimePicker() {
        guard let topController = topMostController() else { return }

        let alert = setupAlert()
        topController.present(alert, animated: true)
    }

    /// Создаёт и настраивает алерт с системным `UIDatePicker` в режиме выбора времени.
    ///
    /// Алерт содержит действия "Cancel" и "OK". При подтверждении выбранное время сохраняется в свойство `time`.
    ///
    /// - Returns: Настроенный `UIAlertController` с добавленным `UIDatePicker`.
    private func setupAlert() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
		datePicker.locale = AppConstants.AppLocale.posix
        datePicker.date = time ?? Date()

        alert.view.addSubviews(datePicker)

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -8),
            datePicker.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -44)
        ])

        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Cancel", comment: ""),
            style: .cancel
        ))

        alert.addAction(UIAlertAction(
            title: NSLocalizedString("ОК", comment: ""),
            style: .default,
            handler: { [weak self] _ in
                self?.time = datePicker.date
            }
        ))

        return alert
    }

    /// Возвращает верхний контроллер в текущем окне приложения.
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
