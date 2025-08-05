//
//  UITextField.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 03.08.2025.
//
import UIKit

extension UITextField {

    /// Добавляет отступ для полей ввода данных
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
