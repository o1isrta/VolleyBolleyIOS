//
//  PopupBannerView.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 25.08.2025.
//

import UIKit

/// Всплывающий баннер с сообщением.
///
/// Отображает `message` с иконкой приглашения слева и стрелкой справа.
/// Баннер появляется с анимацией из-под указанного `anchorView`
/// и автоматически скрывается через заданный интервал.
final class PopupBannerView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let contentInset: CGFloat = 20
        static let fontSize: CGFloat = 16
        static let stackSpacing: CGFloat = 8
        static let cornerRadius: CGFloat = 32
        static let height: CGFloat = 64
        static let inviteImageViewSize: CGFloat = 24
        static let arrowImageViewSize: CGFloat = 16
    }

    // MARK: - Public Properties

    /// Фиксированная высота баннера для авто-лейаута.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: Constants.height)
    }

    // MARK: - Internal Properties

    /// Вызывается при нажатии на баннер.
    var onTap: (() -> Void)?

    // MARK: - Private Properties

    /// Лейбл, отображающий сообщение.
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Hero.bold(size: Constants.fontSize)
        label.textColor = AppColor.Icon.inverted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Иконка приглашения.
    private lazy var inviteImageView: UIImageView = {
        let image = UIImage(resource: .invite).withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = AppColor.Icon.inverted
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    /// Иконка стрелки.
    private lazy var arrowImageView: UIImageView = {
        let image = UIImage(resource: .arrow).withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = AppColor.Icon.inverted
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    /// Горизонтальный стек для размещения иконок и текста.
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [inviteImageView, messageLabel, arrowImageView])
        stack.axis = .horizontal
        stack.spacing = Constants.stackSpacing
        stack.alignment = .center
        return stack
    }()

    /// Градиентный слой фона.
    private var gradientLayer: CAGradientLayer?

    // MARK: - Initializers

    /// Инициализатор баннера.
    ///
    /// - Parameters:
    ///   - message: Текст сообщения для отображения.
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setup()
        setupGradient()
        setupGestureRecognizer()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }

    // MARK: - Internal Methods

    /// Отображает баннер во вью, анимируя его появление.
    /// - Parameters:
    ///   - view: Вью, в которую будет добавлен баннер.
    ///   - anchorView: Вью, из-под которой баннер будет выплывать.
    ///   - offsetY: Отступ по вертикали.
    ///   - horizontalInset: Отступы слева и справа.
    ///   - showDuration: Длительность анимации появления.
    ///   - visibleDuration: Время (в секундах), через которое баннер автоматически скроется.
    func show(
        in view: UIView,
        under anchorView: UIView,
        horizontalInset: CGFloat = 8,
        offsetY: CGFloat = 8,
        showDuration: TimeInterval = 0.5,
        visibleDuration: TimeInterval = 2.0
    ) {
        let anchorFrameInView = anchorView.convert(anchorView.bounds, to: view)
        let targetY = anchorFrameInView.maxY + offsetY

        frame = CGRect(
            x: horizontalInset,
            y: targetY - Constants.height,
            width: view.bounds.width - horizontalInset * 2,
            height: Constants.height
        )

        view.insertSubview(self, belowSubview: anchorView)

        animateIn(to: targetY, duration: showDuration) {
            DispatchQueue.main.asyncAfter(deadline: .now() + visibleDuration) {
                self.animateOut(to: targetY, duration: showDuration)
            }
        }
    }

    // MARK: - Private Methods

    /// Настраивает иерархию и констрейнты.
    private func setup() {
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true

        addSubviews(stackView)

        NSLayoutConstraint.activate([
            inviteImageView.widthAnchor.constraint(equalToConstant: Constants.inviteImageViewSize),
            inviteImageView.heightAnchor.constraint(equalToConstant: Constants.inviteImageViewSize),
            arrowImageView.widthAnchor.constraint(equalToConstant: Constants.arrowImageViewSize),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constants.arrowImageViewSize),

            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.contentInset),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.contentInset),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.contentInset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.contentInset)
        ])
    }

    /// Настраивает градиентный фон.
    private func setupGradient() {
        let gradient = CALayer.getGradientLayer()
        gradient.cornerRadius = Constants.cornerRadius
        layer.insertSublayer(gradient, at: 0)
        gradientLayer = gradient
    }

    /// Настраивает обработчик нажатия.
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }

    /// Обработчик нажатия.
    @objc private func handleTap() {
        onTap?()
    }

    /// Анимирует появление баннера.
    ///
    /// - Parameters:
    ///   - targetY: Финальная координата `y`.
    ///   - duration: Длительность анимации.
    ///   - completion: Замыкание, вызываемое после окончания анимации.
    private func animateIn(to targetY: CGFloat, duration: TimeInterval, completion: @escaping () -> Void) {
        UIView.animate(withDuration: duration) {
            self.frame.origin.y = targetY
        } completion: { _ in
            completion()
        }
    }

    /// Анимирует скрытие баннера с последующим удалением из супервью.
    ///
    /// - Parameters:
    ///   - targetY: Исходная координата `y` (будет смещена на высоту баннера).
    ///   - duration: Длительность анимации.
    private func animateOut(to targetY: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.frame.origin.y = targetY - Constants.height
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

}

// MARK: - Preview

#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview("Popup Banner") {
    PopupBannerViewRepresentable()
        .frame(width: 362, height: 64)
}

#Preview("Popup Banner Demo") {
    PopupBannerViewControllerRepresentable()
        .ignoresSafeArea()
}

struct PopupBannerViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> PopupBannerView {
        PopupBannerView(message: "Anton Ivanov invited you")
    }

    func updateUIView(_ uiView: PopupBannerView, context: Context) {}
}

struct PopupBannerViewControllerRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = AppColor.Background.screen

        let navBar = CustomNavBarView()

        navBar.configure(
            with: NavBarViewModel(
                player: Player(
                    firstName: "Artem",
                    lastName: "Ivanov",
                    gender: "man",
                    paymentType: "visa",
                    paymentAccount: "1234",
                    dateOfBirth: Date(),
                    level: .light,
                    country: .thailand,
                    cityID: 0,
                    avatarURL: nil
                ),
                avatarImage: UIImage(resource: .imgPerson)
            )
        )

        let button = UIButton(type: .system)
        button.setTitle("Show Banner", for: .normal)
        button.addAction(UIAction { _ in
            let banner = PopupBannerView(message: "Anton invited you")
            banner.onTap = {
                print("tap")
            }
            banner.show(in: viewController.view, under: navBar)
        }, for: .touchUpInside)

        viewController.view.addSubviews(navBar, button)

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 106),

            button.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#endif
