import UIKit

final class OnboardingViewController: BaseViewController {
    var onContinue: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func continueTapped() {
        onContinue?()
    }
}
