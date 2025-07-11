import UIKit

protocol HomeViewProtocol: AnyObject {
    func showGreeting(_ message: String)
}

final class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        presenter.viewDidLoad()
    }

    func showGreeting(_ message: String) {
        let label = UILabel()
        label.text = message
        label.textAlignment = .center
        label.font = AppFont.Quantex.regular(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
