//
//  ProfilePhotoPickerVC.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 21.09.2025.
//

import PhotosUI
import UIKit

final class ProfilePhotoPickerVC: UIViewController  {

    var currentImage = UIImage()
    weak var delegate: ProfilePhotoPickerVCDelegate?

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


extension ProfilePhotoPickerVC: PHPickerViewControllerDelegate {
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
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.currentImage = image
                        self.dismiss(animated: true) {
                            self.delegate?.photoPickerDidSelectImage(image)
                        }
                    }
                }
            }
        }
    }
}
