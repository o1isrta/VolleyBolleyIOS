//
//  PersonalDataViewController.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

protocol PersonalDataViewControllerProtocol: AnyObject {

}

final class PersonalDataViewController: BaseViewController, PersonalDataViewControllerProtocol {

    // MARK: - Constants

    private enum LayoutConstants {
        static let mainIndent: CGFloat = 8
        static let mainSpacing: CGFloat = 20
        static let tabBarHeight: CGFloat = 81
        static let backButtonTopInset: CGFloat = 14
    }

    // MARK: - Private Properties

    private let presenter: PersonalDataPresenterProtocol

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var glassmorphismView = GlassmorphismView()

    private lazy var dataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private lazy var screenTitle = CustomTitle(
        text: String(localized: "personalData.screenTitle"),
        isLarge: true
    )
    private lazy var backButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()


    // MARK: - Initializers

    init(presenter: PersonalDataPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

}

// MARK: - Private methods

private extension PersonalDataViewController {

    @objc
    func backButtonTapped() {
        presenter.backButtonTapped()
    }

    func setupView() {
        setupGlassmorphismView()
        setupSubviews()
        setupConstraints()
    }

    private func setupGlassmorphismView() {
        view.addSubviews(glassmorphismView)
        glassmorphismView.layer.cornerRadius = 32
        glassmorphismView.clipsToBounds = true
    }

    private func setupSubviews() {
        [backButton, screenTitle, scrollView].forEach {
            glassmorphismView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(dataStackView)
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            glassmorphismView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            glassmorphismView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.mainIndent),
            glassmorphismView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.mainIndent),
            glassmorphismView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutConstants.tabBarHeight),

            backButton.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: LayoutConstants.backButtonTopInset),
            backButton.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: LayoutConstants.mainSpacing / 2),

            screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
            screenTitle.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: LayoutConstants.mainSpacing),

            scrollView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: glassmorphismView.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            dataStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.mainSpacing),
            dataStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.mainSpacing),
            dataStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.mainSpacing)
        ])
    }
}

#if DEBUG
import SwiftUI

struct  PersonalDataViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: PersonalDataPresenterProtocol {
        weak var view: PersonalDataViewControllerProtocol?
        func viewDidLoad() {}
        func backButtonTapped() {}
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let presenter = StubPresenter()
        return PersonalDataViewController(presenter: presenter)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct PersonalDataViewController_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
