//
//  ProfilePhotoPickerViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import PhotosUI
import UIKit

protocol EditProfilePhotoViewControllerProtocol: AnyObject {
	func updateProfileImage(_ image: UIImage)
	func showLoading(_ isLoading: Bool)
}

protocol ProfilePhotoPickerViewControllerDelegate: AnyObject {
	func photoPickerDidSelectImage(_ image: UIImage)
	func photoPickerDidCancel()
	func photoPickerDidFailWithError(error: String)
}

final class ProfilePhotoPickerViewController: UIViewController {

	var currentImage = UIImage()
	weak var delegate: ProfilePhotoPickerViewControllerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		configurePicker()
	}

	private func configurePicker() {
		var configuration = PHPickerConfiguration()
		configuration.filter = .images
		configuration.selectionLimit = 1
		configuration.preferredAssetRepresentationMode = .current
		let picker = PHPickerViewController(configuration: configuration)
		picker.delegate = self
		present(picker, animated: true)
	}
}

extension ProfilePhotoPickerViewController: PHPickerViewControllerDelegate {

	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		picker.dismiss(animated: true)

		if results.isEmpty {
			self.dismiss(animated: true) {
				self.delegate?.photoPickerDidCancel()
			}
			return
		}

		for result in results {
			result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
				if let error = error {
					DispatchQueue.main.async {
						print("Error loading image: \(error.localizedDescription)")
						self.dismiss(animated: true) {
							self.delegate?.photoPickerDidFailWithError(error: error.localizedDescription)
						}
					}
					return
				}

				if let image = image as? UIImage {
					DispatchQueue.main.async {
						self.currentImage = image
						self.dismiss(animated: true) {
							self.delegate?.photoPickerDidSelectImage(image)
						}
					}
				} else {
					DispatchQueue.main.async {
						let error = NSError(domain: "PhotoPickerErrorDomain",
											code: 1001,
											userInfo: [NSLocalizedDescriptionKey: "Failed to load image"])
						print("Error loading image: \(error.localizedDescription)")
						self.dismiss(animated: true) {
							self.delegate?.photoPickerDidFailWithError(error: error.localizedDescription)
						}
					}
				}
			}
		}
	}
}
