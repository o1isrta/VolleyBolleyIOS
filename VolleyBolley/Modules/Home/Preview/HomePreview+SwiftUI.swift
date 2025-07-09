#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview("Home success") {
    UIViewControllerPreview {
        HomeModulePreviewBuilder.build()
    }
    .edgesIgnoringSafeArea(.all)
}

// Можно добавить доп сценарии

#endif
