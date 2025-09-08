//
//  ProgressHub.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 08.09.2025.
//
import UIKit

/// Класс ProgressHub с анимированным волейбольным мячом
/// Сделан в виде синглтона
/// Имеет два метода:
/// - show - показать анимацию
/// - hide - скрыть анимацию
final class ProgressHub: UIView {

    static let shared = ProgressHub()

    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemThinMaterialDark)
        let visualEffect = UIVisualEffectView(effect: effect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.alpha = 0.6
        return visualEffect
    }()

    private let ballView: UIImageView = {
        let ballView = UIImageView(image: .players)
        ballView.translatesAutoresizingMaskIntoConstraints = false
        ballView.contentMode = .scaleAspectFit
        return ballView
    }()

    // MARK: - Init
    private override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        backgroundColor = AppColor.Background.blur

        addSubview(blurView)
        addSubview(ballView)

        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),

            ballView.centerXAnchor.constraint(equalTo: centerXAnchor),
            ballView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ballView.widthAnchor.constraint(equalToConstant: 44),
            ballView.heightAnchor.constraint(equalToConstant: 44)
        ])
        alpha = 0
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func startSpin() {
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.fromValue = 0
        anim.toValue = CGFloat.pi * 2
        anim.duration = 1.0
        anim.repeatCount = .infinity
        anim.timingFunction = CAMediaTimingFunction(name: .linear)
        ballView.layer.add(anim, forKey: "spin")
    }

    private func stopSpin() {
        ballView.layer.removeAnimation(forKey: "spin")
    }

    func show(in view: UIView) {
        DispatchQueue.main.async {
            if self.superview == nil {
                self.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(self)
                NSLayoutConstraint.activate([
                    self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    self.topAnchor.constraint(equalTo: view.topAnchor),
                    self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
            }
            self.startSpin()
            UIView.animate(withDuration: 0.2) { self.alpha = 1 }
        }
    }

    func hide() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: { self.alpha = 0 }) { _ in
                self.stopSpin()
                self.removeFromSuperview()
            }
        }
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    ProgressHubPreviewViewController()
}

final class ProgressHubPreviewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        ProgressHub.shared.show(in: view)
    }
}
#endif
