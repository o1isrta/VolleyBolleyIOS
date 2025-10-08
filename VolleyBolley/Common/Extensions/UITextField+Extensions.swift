//
//  UITextField.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 03.08.2025.
//
import UIKit

extension UITextField {

    /// Добавляет отступ для полей ввода данных
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    /// Ставит курсор в конец текста
    func moveCursorToEnd() {
        let endPosition = endOfDocument
        selectedTextRange = textRange(from: endPosition, to: endPosition)
    }

    /// Обновляет текст с учётом форматирования и опционально двигает курсор в конец
    func updateFormattedText(
        range: NSRange,
        replacementString string: String,
        formatter: (String) -> String?,
        forceCursorToEnd: Bool = true
    ) -> Bool {
        let currentText = text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        guard let formattedText = formatter(updatedText) else {
            return false
        }

        text = formattedText

        if forceCursorToEnd {
            moveCursorToEnd()
        }

        return false
    }
}
