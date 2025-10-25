//
//  EditProfilePhotoViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

protocol EditProfilePhotoViewControllerProtocol: AnyObject {
	func updateProfileImage(_ image: UIImage)
	func showLoading(_ isLoading: Bool)
	func showAlert(with message: String)
}

final class EditProfilePhotoViewController: BaseViewController {

	// MARK: - Public Properties

	var presenter: EditProfilePhotoPresenterProtocol?

	// MARK: - Private Properties

	private enum LayoutConstants {
		static let mainIndent: CGFloat = 8
		static let mediumIndent: CGFloat = 16
		static let mainSpacing: CGFloat = 20
		static let backButtonTopInset: CGFloat = 14

		static let profilePhotoSize: CGFloat = 122
		static let photoActionTableViewHeight: CGFloat = 174
		static let glassmorphismViewHeight: CGFloat = 454
		static let saveButtonHeight: CGFloat = 44
	}

	private lazy var glassmorphismView = GlassmorphismView()
	private lazy var screenTitle = CustomTitle(
		text: String(localized: "editProfilePhoto.title"),
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

	private lazy var profilePhotoView = AvatarImageView()
	private lazy var photoActionTableView: EditProfilePhotoActionsTableView = {
		let tableView = EditProfilePhotoActionsTableView()
		tableView.didSelectAction = { [weak self] index in
			guard let action = PhotoAction(rawValue: index) else { return }
			self?.showLoading(true)
			self?.presenter?.didSelectAction(action)
		}
		return tableView
	}()
	private lazy var saveButton: YellowButton = {
		let button = YellowButton(title: String(localized: "button.save"))
		button.isSelected = true
		button.isEnabled = true
		button.addAction(UIAction { [weak self] _ in
			guard let image = self?.profilePhotoView.image else { return }
			self?.presenter?.saveButtonTapped(image: image)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var mainStack: UIStackView = {
		profilePhotoView.setContentHuggingPriority(.required, for: .horizontal)
		profilePhotoView.setContentHuggingPriority(.required, for: .vertical)
		profilePhotoView.setContentCompressionResistancePriority(.required, for: .horizontal)
		profilePhotoView.setContentCompressionResistancePriority(.required, for: .vertical)
		let stack = UIStackView(arrangedSubviews: [
			profilePhotoView,
			photoActionTableView,
			saveButton
		])
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = LayoutConstants.mediumIndent
		return stack
	}()

	private let loadingIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .large)
		indicator.hidesWhenStopped = true
		indicator.color = AppColor.Background.primary
		return indicator
	}()

	// MARK: - Public Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		presenter?.viewDidLoad()
	}

	private lazy var customAlertView: CustomAlertView = {
		let view = CustomAlertView()
		view.isHidden = true// TODO: remove it in the future
		return view
	}()

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		// ALWAYS raise the customAlertView above all other subviews
		view.bringSubviewToFront(customAlertView)
	}
}

// MARK: - Private Methods

private extension EditProfilePhotoViewController {

	func setupView() {
		setupViews()
		setupConstraints()
		setupLoadingIndicator()
	}

	func setupViews() {
		view.addSubviews(
			glassmorphismView,
			customAlertView
		)
		glassmorphismView.addSubviews(
			backButton,
			screenTitle,
			mainStack
		)
	}

	func setupLoadingIndicator() {
		view.addSubviews(loadingIndicator)
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: profilePhotoView.centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: profilePhotoView.centerYAnchor)
		])
	}

	func setupConstraints() {
		customAlertView.pinToSuperviewEdges()
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

			profilePhotoView.widthAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),
			profilePhotoView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),

			mainStack.topAnchor.constraint(
				equalTo: screenTitle.bottomAnchor,
				constant: LayoutConstants.mediumIndent),
			mainStack.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing),
			mainStack.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor, constant: -LayoutConstants.mainSpacing),

			photoActionTableView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.photoActionTableViewHeight),
			photoActionTableView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			photoActionTableView.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),

			saveButton.heightAnchor.constraint(
				equalToConstant: LayoutConstants.saveButtonHeight),
			saveButton.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			saveButton.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor)
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
			showAlert(with: PhotoPickerError.failedCameraLoadImage.localizedDescription)
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
			isLoading
				? self.loadingIndicator.startAnimating()
				: self.loadingIndicator.stopAnimating()
			self.view.isUserInteractionEnabled = !isLoading
		}
	}

	func showAlert(with message: String) {
		customAlertView.isHidden = false
		let model = CustomAlertModel(
			message: message,
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.ok"),
				action: { self.customAlertView.isHidden = true }
			)
		)
		customAlertView.configure(with: model)
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
