//
//  KingfisherImageLoadingService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Kingfisher
import UIKit

protocol ImageLoadingServiceProtocol {
    func loadImage(from url: URL) async throws -> UIImage?
}

final class KingfisherImageLoadingService: ImageLoadingServiceProtocol {

    func loadImage(from url: URL) async throws -> UIImage? {
        try await withCheckedThrowingContinuation { continuation in
            let resource = KF.ImageResource(downloadURL: url)
            KingfisherManager.shared.retrieveImage(with: resource) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value.image)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
