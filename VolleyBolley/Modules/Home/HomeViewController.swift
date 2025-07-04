import UIKit

protocol HomeViewProtocol: AnyObject {
    func showGreeting(_ message: String)
}

final class HomeViewController: BaseViewController, HomeViewProtocol {
    private let presenter: HomePresenterProtocol

    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
