#if DEBUG
import SwiftUI

struct UIViewControllerPreview: UIViewControllerRepresentable {
    let viewController: () -> UIViewController

    init(_ builder: @escaping () -> UIViewController) {
        self.viewController = builder
    }

    func makeUIViewController(context: Context) -> UIViewController {
        viewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
#endif
