//
//  UIView.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.07.2025.
//
import UIKit

extension UIView {
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
