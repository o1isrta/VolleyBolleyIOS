//
//  PersonalDataViewController.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

protocol PersonalDataViewProtocol: AnyObject {

}

final class PersonalDataViewController: BaseViewController, PersonalDataViewProtocol {

    // MARK: - Constants

    private enum Constants {
        static let mainIndent: CGFloat = 8
        static let mainSpacing: CGFloat = 20
        static let mediumSpacing: CGFloat = 16
        static let tabBarHeight: CGFloat = 81
        static let backButtonTopInset: CGFloat = 14
        static let profileImageSize: CGFloat = 122
        static let editButtonSize: CGFloat = 24
        static let glassmorphismCornerRadius: CGFloat = 32
    }

    // MARK: - Private Properties

    private let presenter: PersonalDataPresenterProtocol

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var glassmorphismView = GlassmorphismView()

    private var selectedGender: String? = String(localized: "Male")

    private lazy var formStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.mediumSpacing
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

    private lazy var profileContainerView = UIView()

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Icon.profile
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        let pencilImage = UIImage.Icon.pencil.withRenderingMode(.alwaysOriginal)
        button.setImage(pencilImage, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Form fields

    private lazy var nameLabel = CustomLabel(text: String(localized: "Name"), isBold: true)
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String(localized: "Anton")
        textField.backgroundColor = AppColor.Border.primary
        textField.layer.cornerRadius = 16
        textField.textColor = AppColor.Text.placeHolder
        textField.setLeftPaddingPoints(16)
        return textField
    }()

    private lazy var surnameLabel = CustomLabel(text: String(localized: "Surname"), isBold: true)
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String(localized: "Ivanov")
        textField.backgroundColor = AppColor.Border.primary
        textField.layer.cornerRadius = 16
        textField.textColor = AppColor.Text.placeHolder
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    private lazy var surnameSeparator = CustomSeparator()

    private lazy var genderLabel = CustomLabel(text: String(localized: "Gender"), isBold: true)
    private lazy var maleButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Male"), for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var femaleButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Female"), for: .normal)
        button.isSelected = false
        button.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var genderButtonsStackView: UIStackView = {
        let view = UIView()
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        let stack = UIStackView(arrangedSubviews: [
            maleButton,
            femaleButton,
            view
        ])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private lazy var genderSeparator = CustomSeparator()

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

    @objc
    private func editButtonTapped() {
        // TODO: Редактирование фото профиля
        print("Редактирование фото")
    }

    @objc
    private func genderButtonTapped(_ sender: UIButton) {
        [maleButton, femaleButton].forEach { $0.isSelected = false }
        sender.isSelected = true
        selectedGender = sender.title(for: .normal)
    }

    func setupView() {
        setupGlassmorphismView()
        setupSubviews()
        setupConstraints()
    }

    private func setupGlassmorphismView() {
        view.addSubviews(glassmorphismView)
        glassmorphismView.layer.cornerRadius = Constants.glassmorphismCornerRadius
        glassmorphismView.clipsToBounds = true
    }

    private func setupSubviews() {
        glassmorphismView.addSubviews(backButton, screenTitle, scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(formStackView)
        profileContainerView.addSubviews(profileImageView, editButton)

        [profileContainerView,
         nameLabel, nameTextField,
         surnameLabel, surnameTextField, surnameSeparator,
         genderLabel, genderButtonsStackView, genderSeparator
        ].forEach {
            formStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            glassmorphismView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            glassmorphismView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.mainIndent),
            glassmorphismView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.mainIndent),
            glassmorphismView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.tabBarHeight),

            backButton.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: Constants.backButtonTopInset),
            backButton.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: Constants.mainSpacing / 2),

            screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
            screenTitle.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: Constants.mainSpacing),

            scrollView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: Constants.mediumSpacing),
            scrollView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: glassmorphismView.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            formStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            formStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.mainSpacing),
            formStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.mainSpacing),
            formStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.mainSpacing),

            // Form Constraints

            profileContainerView.topAnchor.constraint(equalTo: formStackView.topAnchor),
            profileContainerView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),

            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.centerXAnchor.constraint(equalTo: profileContainerView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: profileContainerView.topAnchor),

            editButton.widthAnchor.constraint(equalToConstant: Constants.editButtonSize),
            editButton.heightAnchor.constraint(equalToConstant: Constants.editButtonSize),
            editButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -12),
            editButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -8),

            nameLabel.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 51),

            surnameLabel.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),

            surnameTextField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 8),
            surnameTextField.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            surnameTextField.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor),
            surnameTextField.heightAnchor.constraint(equalToConstant: 51),

            surnameSeparator.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            surnameSeparator.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor),

            genderLabel.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),

            genderButtonsStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),

            genderSeparator.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            genderSeparator.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor),
        ])
    }
}

#if DEBUG
import SwiftUI

struct  PersonalDataViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: PersonalDataPresenterProtocol {
        weak var view: PersonalDataViewProtocol?
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
