//
//  MockImageLoadingService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import UIKit

final class MockImageLoadingService: ImageLoadingServiceProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let mockImage: UIImage? = .imgPerson
        completion(mockImage)
    }
}
