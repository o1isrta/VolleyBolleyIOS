//
//  UIView+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 04.07.2025.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            if let vc = nextResponder as? UIViewController {
                return vc
            }
        }
        return nil
    }

    func findSuperview<T: UIView>(ofType type: T.Type) -> T? {
        var view = self.superview
        while view != nil {
            if let typedView = view as? T {
                return typedView
            }
            view = view?.superview
        }
        return nil
    }
}
