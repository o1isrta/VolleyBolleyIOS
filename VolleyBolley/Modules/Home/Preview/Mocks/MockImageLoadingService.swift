//
//  MockImageLoadingService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import UIKit

final class MockImageLoadingService: ImageLoadingServiceProtocol {
    func loadImage(from url: URL) async throws -> UIImage? {
        .imgPerson
    }
}
