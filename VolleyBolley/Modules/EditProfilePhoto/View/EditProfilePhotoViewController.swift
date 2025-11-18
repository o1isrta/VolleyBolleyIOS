//
//  EditProfilePhotoViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

protocol EditProfilePhotoViewControllerProtocol: AnyObject {
	var presenter: EditProfilePhotoPresenterProtocol? { get set }
	func updateProfileImage(_ image: UIImage)
	func isLoadingIndicatorVisible(_ isLoading: Bool)
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

	private let loadingIndicator = ProgressHub.shared

	private lazy var glassView = GlassView()
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
			self?.isLoadingIndicatorVisible(true)
			self?.presenter?.didSelectAction(action)
		}
		return tableView
	}()
	private lazy var saveButton: YellowButton = {
		let button = YellowButton(title: String(localized: "button.save"))
		button.isSelected = true
		button.isEnabled = true
		button.addAction(UIAction { [weak self] _ in
			let image = self?.profilePhotoView.image
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

	private lazy var customAlertView: CustomAlertView = CustomAlertView()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		view.bringSubviewToFront(customAlertView)
		view.bringSubviewToFront(loadingIndicator)
	}
}

// MARK: - Private Methods

private extension EditProfilePhotoViewController {

	func setupView() {
		setupViews()
		setupConstraints()
	}

	func setupViews() {
		view.addSubviews(
            glassView,
			customAlertView
		)
        glassView.addSubviews(
			backButton,
			screenTitle,
			mainStack
		)
	}

	func setupConstraints() {
		customAlertView.pinToSuperviewEdges()
		NSLayoutConstraint.activate([
            glassView.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: LayoutConstants.mainIndent),
            glassView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: LayoutConstants.mainIndent),
            glassView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -LayoutConstants.mainIndent),
            glassView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.glassmorphismViewHeight),

			backButton.topAnchor.constraint(
				equalTo: glassView.topAnchor,
				constant: LayoutConstants.backButtonTopInset),
			backButton.leadingAnchor.constraint(
				equalTo: glassView.leadingAnchor,
				constant: LayoutConstants.mainSpacing / 2),

			screenTitle.centerXAnchor.constraint(equalTo: glassView.centerXAnchor),
			screenTitle.topAnchor.constraint(
				equalTo: glassView.topAnchor,
				constant: LayoutConstants.mainSpacing),

			profilePhotoView.widthAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),
			profilePhotoView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),

			mainStack.topAnchor.constraint(
				equalTo: screenTitle.bottomAnchor,
				constant: LayoutConstants.mediumIndent),
			mainStack.leadingAnchor.constraint(
				equalTo: glassView.leadingAnchor,
				constant: LayoutConstants.mainSpacing),
			mainStack.trailingAnchor.constraint(
				equalTo: glassView.trailingAnchor, constant: -LayoutConstants.mainSpacing),

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

extension EditProfilePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
		isLoadingIndicatorVisible(false)
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
			self.isLoadingIndicatorVisible(false)
		}
	}

	func isLoadingIndicatorVisible(_ isLoading: Bool) {
		DispatchQueue.main.async {
			isLoading
				? self.loadingIndicator.show(in: self.view, withBlur: true, ballSize: .big)
				: self.loadingIndicator.hide()
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
	let view = EditProfilePhotoViewController()
	let router = EditProfilePhotoRouter()
	let interactor = EditProfilePhotoInteractor()
	let presenter = EditProfilePhotoPresenter(
		view: view,
		interactor: interactor,
		router: router
	)
	view.presenter = presenter
	interactor.presenter = presenter
	router.attachViewController(view)

	return view
}
#endif
