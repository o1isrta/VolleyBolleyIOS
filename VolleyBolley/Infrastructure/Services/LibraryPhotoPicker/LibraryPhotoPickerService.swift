//
//  PhotoPickerService.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import PhotosUI
import UIKit

/// Delegate protocol for handling photo picker events
///
/// Implement this protocol to receive callbacks when user:
/// - Selects an image from the photo library
/// - Cancels the photo picking process
/// - Encounters an error during image loading
protocol LibraryPhotoPickerServiceDelegate: AnyObject {

	/// Called when user successfully selects an image from the photo library
	/// - Parameter image: The selected UIImage ready for use
	func photoPickerDidSelectImage(_ image: UIImage)

	/// Called when user cancels the photo picking process without selecting an image
	func photoPickerDidCancel()

	/// Called when an error occurs during image loading or selection
	/// - Parameter error: The error that occurred during the process
	func photoPickerDidFailWithError(_ error: Error)
}

/// Service for handling photo selection from device's photo library
///
/// This class provides a simple interface for presenting the system photo picker
/// and handling image selection using PHPickerViewController.
/// It manages the entire flow from presentation to image loading and error handling.
final class LibraryPhotoPickerService: UIViewController {

	// MARK: - Public Properties

	/// The delegate that receives photo picker events
	///
	/// Set this property to receive callbacks for image selection, cancellation, and errors.
	weak var delegate: LibraryPhotoPickerServiceDelegate?

	// MARK: - Public Methods

	/// View controller lifecycle method
	///
	/// Automatically presents the photo picker when the view loads.
	/// This ensures the picker is shown immediately when this service is presented.
	override func viewDidLoad() {
		super.viewDidLoad()
		configurePicker()
	}
}

// MARK: - PHPickerViewControllerDelegate

extension LibraryPhotoPickerService: PHPickerViewControllerDelegate {

	/// Handles the completion of photo selection process
	///
	/// - Parameters:
	///   - picker: The PHPickerViewController that finished picking
	///   - results: Array of PHPickerResult containing selected assets
	///
	/// This method:
	/// 1. Dismisses the picker immediately
	/// 2. Checks if any image was selected
	/// 3. Initiates image loading for the first selected result
	/// 4. Handles cancellation if no results are present
	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		picker.dismiss(animated: true)

		guard let result = results.first else {
			handleCancellation()
			return
		}

		loadImage(from: result.itemProvider)
	}
}

// MARK: - Private Methods

private extension LibraryPhotoPickerService {

	/// Configures and presents the system photo picker
	///
	/// Sets up PHPickerViewController with the following configuration:
	/// - Images only filter
	/// - Single selection limit
	/// - Current asset representation mode for optimal performance
	func configurePicker() {
		var configuration = PHPickerConfiguration()
		configuration.filter = .images
		configuration.selectionLimit = 1
		configuration.preferredAssetRepresentationMode = .current

		let picker = PHPickerViewController(configuration: configuration)
		picker.delegate = self
		present(picker, animated: true)
	}

	/// Loads image data from the provided item provider
	///
	/// - Parameter itemProvider: The NSItemProvider containing the selected image
	///
	/// This method:
	/// 1. Asynchronously loads the UIImage from the item provider
	/// 2. Handles any loading errors
	/// 3. Validates that the loaded object is actually a UIImage
	/// 4. Ensures all UI updates happen on the main thread
	func loadImage(from itemProvider: NSItemProvider) {
		itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
			DispatchQueue.main.async {
				if let error = error {
					self?.handleError(error)
					return
				}

				guard let image = image as? UIImage else {
					self?.handleError(PhotoPickerError.failedLibraryLoadImage)
					return
				}

				self?.handleSuccess(image)
			}
		}
	}

	/// Handles successful image loading and selection
	///
	/// - Parameter image: The successfully loaded UIImage
	///
	/// Dismisses the photo picker service and notifies the delegate
	/// about the successful image selection.
	func handleSuccess(_ image: UIImage) {
		dismiss(animated: true) { [delegate] in
			delegate?.photoPickerDidSelectImage(image)
		}
	}

	/// Handles errors that occur during image loading
	///
	/// - Parameter error: The error that occurred
	///
	/// Dismisses the photo picker service and notifies the delegate
	/// about the error with specific error details.
	func handleError(_ error: Error) {
		dismiss(animated: true) { [delegate] in
			delegate?.photoPickerDidFailWithError(error)
		}
	}

	/// Handles user cancellation of photo picking process
	///
	/// Dismisses the photo picker service and notifies the delegate
	/// that the user cancelled the operation.
	func handleCancellation() {
		dismiss(animated: true) { [delegate] in
			delegate?.photoPickerDidCancel()
		}
	}
}
