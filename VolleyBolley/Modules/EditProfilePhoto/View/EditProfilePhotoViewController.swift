//
//  EditProfilePhotoViewController.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//
#if DEBUG
import SwiftUI
#endif
import UIKit

final class EditProfilePhotoViewController: BaseViewController {

    // MARK: - Constants

    private enum LayoutConstants {
        static let mainIndent: CGFloat = 8
        static let mainSpacing: CGFloat = 20
        static let tabBarHeight: CGFloat = 81
        static let backButtonTopInset: CGFloat = 14
    }

    // MARK: - Public Properties

    var presenter: EditProfilePhotoPresenterProtocol?
    var router: EditProfilePhotoRouterProtocol?

    // MARK: - Private Properties
    private var currentImage = UIImage()
    private let contentView = UIView()
    private lazy var glassmorphismView = GlassmorphismView()
    private lazy var photoActionTableView: PhotoActionsTableView = {
        let tableView = PhotoActionsTableView()
        tableView.didSelectAction = { [weak self] index in
            self?.presenter?.didSelectAction(at: index)
        }
        return tableView
    }()

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
        profilePhotoView.backgroundColor = AppColor.Background.clear
        profilePhotoView.clipsToBounds = true
        profilePhotoView.layer.cornerRadius = 61
        profilePhotoView.layer.borderWidth = 2
        profilePhotoView.layer.borderColor = AppColor.Border.primary.cgColor
        return profilePhotoView
    }()

    private lazy var pencilView: UIImageView = {
        let image = UIImage.editPencil
        let pencilView = UIImageView(image: image)
        return pencilView
    }()

    private lazy var saveButton: YellowButton = {
//        let button = YellowButton(title: "SAVE")
        let button = YellowButton(title: String(localized: "SAVE"))
        button.isSelected = true
        button.isEnabled = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = AppColor.Background.primary
        return indicator
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
}

// MARK: - Private methods
private extension EditProfilePhotoViewController {

    @objc
    func backButtonTapped() {
        presenter?.backButtonTapped()
    }

    @objc
    func saveButtonTapped() {
        guard let image = profilePhotoView.image else { return }
        presenter?.saveButtonTapped(image: image)
    }

    func setupView() {
        setupGlassmorphismView()
        setupSubviews()
        setupConstraints()
        setupLoadingIndicator()
    }

    private func setupGlassmorphismView() {
        view.addSubviews(glassmorphismView)
        glassmorphismView.layer.cornerRadius = 32
        glassmorphismView.clipsToBounds = true
    }

    private func setupSubviews() {
        [backButton, screenTitle, profilePhotoView, pencilView, photoActionTableView, saveButton].forEach {
            glassmorphismView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: profilePhotoView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: profilePhotoView.centerYAnchor)
        ])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            glassmorphismView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            glassmorphismView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: LayoutConstants.mainIndent),
            glassmorphismView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                        constant: -LayoutConstants.mainIndent),
            glassmorphismView.heightAnchor.constraint(equalToConstant: 454),
//            glassmorphismView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
//                                                      constant: -LayoutConstants.tabBarHeight),
            backButton.topAnchor.constraint(equalTo: glassmorphismView.topAnchor,
                                            constant: LayoutConstants.backButtonTopInset),
            backButton.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor,
                                                constant: LayoutConstants.mainSpacing / 2),
            screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
            screenTitle.topAnchor.constraint(equalTo: glassmorphismView.topAnchor,
                                             constant: LayoutConstants.mainSpacing),
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
            photoActionTableView.heightAnchor.constraint(equalToConstant: 180),
            saveButton.topAnchor.constraint(equalTo: photoActionTableView.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditProfilePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else {
            router?.showErrorAlert(message: "Failed to get image from camera")
            return
        }
        updateProfileImage(image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        showLoading(false)
    }
}

// MARK: - EditProfilePhotoViewControllerProtocol
extension EditProfilePhotoViewController: EditProfilePhotoViewControllerProtocol {

    func updateProfileImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.profilePhotoView.image = image
            self.profilePhotoView.contentMode = .scaleAspectFill
            UIView.transition(with: self.profilePhotoView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                self.profilePhotoView.image = image
            },
                              completion: nil)
            self.showLoading(false)
        }
    }

    func showLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = !isLoading
        }
    }

    func showError(message: String) {
        DispatchQueue.main.async {
            self.router?.showErrorAlert(message: message)
        }
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    EditProfilePhotoViewController()
}
#endif
