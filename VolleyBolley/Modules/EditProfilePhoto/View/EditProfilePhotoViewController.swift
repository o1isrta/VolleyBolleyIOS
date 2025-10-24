//
//  EditProfilePhotoViewController.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import UIKit

final class EditProfilePhotoViewController: BaseViewController {

	// MARK: - Public Properties

	var presenter: EditProfilePhotoPresenterProtocol?
	var router: EditProfilePhotoRouterProtocol?

	// MARK: - Private Properties

	private enum LayoutConstants {
		static let mainIndent: CGFloat = 8
		static let mediumIndent: CGFloat = 16
		static let mainSpacing: CGFloat = 20
		static let backButtonTopInset: CGFloat = 14

		static let profilePhotoSize: CGFloat = 122
		static let photoActionTableViewHeight: CGFloat = 176
		static let glassmorphismViewHeight: CGFloat = 454
		static let saveButtonHeight: CGFloat = 44
	}

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
		button.addAction(UIAction { [weak self] _ in
			self?.presenter?.backButtonTapped()
		}, for: .touchUpInside)
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
		let button = YellowButton(title: String(localized: "SAVE"))
		button.isSelected = true
		button.isEnabled = true
		button.addAction(UIAction { [weak self] _ in
			guard let image = self?.profilePhotoView.image else { return }
			self?.presenter?.saveButtonTapped(image: image)
		}, for: .touchUpInside)
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

	func setupView() {
		setupGlassmorphismView()
		setupSubviews()
		setupConstraints()
		setupLoadingIndicator()
	}

	private func setupGlassmorphismView() {
		view.addSubviews(glassmorphismView)
	}

	private func setupSubviews() {
		glassmorphismView.addSubviews(
			backButton,
			screenTitle,
			profilePhotoView,
			pencilView,
			photoActionTableView,
			saveButton
		)
	}

	private func setupLoadingIndicator() {
		view.addSubviews(loadingIndicator)
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: profilePhotoView.centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: profilePhotoView.centerYAnchor)
		])
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: LayoutConstants.mainIndent),
			glassmorphismView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: LayoutConstants.mainIndent),
			glassmorphismView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -LayoutConstants.mainIndent),
			glassmorphismView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.glassmorphismViewHeight),

			backButton.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: LayoutConstants.backButtonTopInset),
			backButton.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing / 2),

			screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
			screenTitle.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: LayoutConstants.mainSpacing),

			profilePhotoView.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
			profilePhotoView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: LayoutConstants.mediumIndent),
			profilePhotoView.widthAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),
			profilePhotoView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),

			pencilView.leadingAnchor.constraint(equalTo: profilePhotoView.leadingAnchor, constant: 87.09),
			pencilView.trailingAnchor.constraint(equalTo: profilePhotoView.trailingAnchor, constant: -10.09),
			pencilView.topAnchor.constraint(equalTo: profilePhotoView.topAnchor, constant: 91.39),
			pencilView.bottomAnchor.constraint(equalTo: profilePhotoView.bottomAnchor, constant: -5.78),

			photoActionTableView.topAnchor.constraint(
				equalTo: profilePhotoView.bottomAnchor,
				constant: LayoutConstants.mediumIndent),
			photoActionTableView.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing),
			photoActionTableView.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor, constant: -LayoutConstants.mainSpacing),
			photoActionTableView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.photoActionTableViewHeight),

			saveButton.topAnchor.constraint(
				equalTo: photoActionTableView.bottomAnchor,
				constant: LayoutConstants.mediumIndent),
			saveButton.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing),
			saveButton.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor,
				constant: -LayoutConstants.mainSpacing),
			saveButton.heightAnchor.constraint(
				equalToConstant: LayoutConstants.saveButtonHeight)
		])
	}
}

// MARK: - UIImagePickerControllerDelegate

extension EditProfilePhotoViewController: UIImagePickerControllerDelegate {

	func imagePickerController(
		_ picker: UIImagePickerController,
		didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
	) {
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
			}, completion: nil)
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

// MARK: - Preview

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	EditProfilePhotoViewController()
}
#endif
