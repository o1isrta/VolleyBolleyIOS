import UIKit

enum AppFont {
    
    // MARK: - Hero
    enum Hero {
        static func regular(size: CGFloat) -> UIFont {
            font(named: "Hero-Regular", size: size)
        }
        static func bold(size: CGFloat) -> UIFont {
            font(named: "Hero-Bold", size: size)
        }
        static func light(size: CGFloat) -> UIFont {
            font(named: "Hero-Light", size: size)
        }
    }
    
    // MARK: - Actay Wide
    enum ActayWide {
        static func bold(size: CGFloat) -> UIFont {
            font(named: "ActayWide-Bold", size: size)
        }
    }
    
    // MARK: - Quantex
    enum Quantex {
        static func regular(size: CGFloat) -> UIFont {
            font(named: "Quantex-Regular", size: size)
        }
    }
    
    // MARK: - Private helper
    private static func font(named name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            assertionFailure("Error: Font '\(name)' not found. Check if it's correctly added to Info.plist and bundle.")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
