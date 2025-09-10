//
//  EditProfilePhotoViewController.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import UIKit

protocol EditProfilePhotoViewControllerProtocol: AnyObject {

}

final class EditProfilePhotoViewController: BaseViewController {

    // MARK: - Constants

    private enum LayoutConstants {
        static let mainIndent: CGFloat = 8
        static let mainSpacing: CGFloat = 20
        static let tabBarHeight: CGFloat = 81
        static let backButtonTopInset: CGFloat = 14
    }

    // MARK: - Private Properties

    private let presenter: EditProfilePhotoPresenterProtocol

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var glassmorphismView = GlassmorphismView()
    private var photoActionTableView = PhotoActionsTableView()

    private lazy var screenTitle = CustomTitle(
        text: String(localized: "Change photo"),
        isLarge: true
    )

    private lazy var backButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var profilePhotoView: UIImageView = {
        let image = UIImage.imgPerson
        let profilePhotoView = UIImageView(image: image)
        profilePhotoView.contentMode = .scaleAspectFill
        profilePhotoView.backgroundColor = .clear
        profilePhotoView.clipsToBounds = true
        profilePhotoView.layer.cornerRadius = 61
        profilePhotoView.layer.borderWidth = 2
        profilePhotoView.layer.borderColor = UIColor.white.cgColor
        return profilePhotoView
    }()

    private lazy var pencilView: UIImageView = {
        let image = UIImage.editPencil
        let pencilView = UIImageView(image: image)
        return pencilView
    }()

    private lazy var saveButton: YellowButton = {
        let button = YellowButton(title: "SAVE")
        button.isSelected = true
        button.isEnabled = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializers

    init(presenter: EditProfilePhotoPresenterProtocol) {
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
private extension EditProfilePhotoViewController {

    @objc
    func backButtonTapped() {
        print("in backButtonTapped function")
        presenter.backButtonTapped()
    }

    @objc
    func saveButtonTapped() {
        print("Save Button Tapped")
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
//        [backButton, screenTitle, scrollView, profilePhotoView].forEach {
        [backButton, screenTitle, profilePhotoView, pencilView, photoActionTableView, saveButton].forEach {
            glassmorphismView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

//        scrollView.addSubview(contentView)
//        contentView.translatesAutoresizingMaskIntoConstraints = false

//        contentView.addSubview(profilePhotoView)
//        contentView.backgroundColor = .clear
//        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false

//        contentView.addSubview(dataStackView)
//        dataStackView.translatesAutoresizingMaskIntoConstraints = false
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

            profilePhotoView.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
            profilePhotoView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 16),
            profilePhotoView.widthAnchor.constraint(equalToConstant: 122),
            profilePhotoView.heightAnchor.constraint(equalToConstant: 122),
            pencilView.leadingAnchor.constraint(equalTo: profilePhotoView.leadingAnchor, constant: 87.09),
            pencilView.trailingAnchor.constraint(equalTo: profilePhotoView.trailingAnchor, constant: -10.09),
            pencilView.topAnchor.constraint(equalTo: profilePhotoView.topAnchor, constant: 91.39),
            pencilView.bottomAnchor.constraint(equalTo: profilePhotoView.bottomAnchor, constant: -5.78),
            photoActionTableView.topAnchor.constraint(equalTo: profilePhotoView.bottomAnchor, constant: 16),
            photoActionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            photoActionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            photoActionTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoActionTableView.widthAnchor.constraint(equalToConstant: 280),
            photoActionTableView.heightAnchor.constraint(equalToConstant: 180),
            saveButton.topAnchor.constraint(equalTo: photoActionTableView.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

#if DEBUG
import SwiftUI

struct  EditProfilePhotoViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: EditProfilePhotoPresenterProtocol {
        weak var view: EditProfilePhotoViewControllerProtocol?
        func viewDidLoad() {}
        func backButtonTapped() {}
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let presenter = StubPresenter()
        return EditProfilePhotoViewController(presenter: presenter)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct PersonalDataViewController_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePhotoViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
