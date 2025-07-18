//
//  KingfisherImageLoadingService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Kingfisher
import UIKit

final class KingfisherImageLoadingService: ImageLoadingServiceProtocol {

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let resource = KF.ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure:
                completion(nil)
            }
        }
    }
}
