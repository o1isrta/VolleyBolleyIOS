import UIKit

/// A base view controller providing common UI setup for all inheriting view controllers.
///
/// `BaseViewController` is designed to be subclassed by other view controllers in the app,
/// ensuring a consistent appearance and behavior. It sets the default background color and
/// configures the navigation bar to be hidden. Subclasses can override or extend these behaviors
/// as needed.
/// 
/// - Important: This class automatically hides the navigation bar and sets the screen background color using `AppColor.Background.screen`.
///
/// - SeeAlso: `UIViewController`
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseUI()
    }

    private func configureBaseUI() {
        view.backgroundColor = AppColor.Background.screen

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
