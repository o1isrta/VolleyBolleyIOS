//
//  PhotoPickerError.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import Foundation

/// Errors that can occur during photo picking process
///
/// Use these errors to handle different failure scenarios when working with
/// camera and photo library. Each case provides a localized description
/// suitable for displaying to the user.
enum PhotoPickerError: Error {

	/// The device doesn't have a camera or camera is not accessible
	///
	/// This can occur on:
	/// - Simulator without camera configuration
	/// - Devices with hardware failure
	/// - When camera permissions are denied
	case cameraUnavailable

	/// Failed to load image from camera capture
	///
	/// This typically happens when:
	/// - Camera hardware fails during capture
	/// - Image data is corrupted or invalid
	/// - Memory issues during image processing
	case failedCameraLoadImage

	/// Failed to load image from photo library
	///
	/// Common causes include:
	/// - Insufficient permissions to access photo library
	/// - Corrupted or unsupported image format
	/// - Network storage (iCloud) synchronization issues
	case failedLibraryLoadImage

	/// Localized description for user-facing error messages
	///
	/// Returns user-friendly messages that can be directly displayed in UI.
	/// Messages are localized using String(localized:) for internationalization.
	var localizedDescription: String {
		switch self {
		case .cameraUnavailable: return String(localized: "photoPicker.cameraUnavailable")
		case .failedCameraLoadImage: return String(localized: "photoPicker.failedCameraLoadImage")
		case .failedLibraryLoadImage: return String(localized: "photoPicker.failedLibraryLoadImage")
		}
	}
}
