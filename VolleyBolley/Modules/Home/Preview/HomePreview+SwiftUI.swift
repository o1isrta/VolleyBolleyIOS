#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview("Home") {
    UIViewControllerPreview {
        HomeModulePreviewBuilder.build()
    }
    .edgesIgnoringSafeArea(.all)
}

#endif
