//
//  ImageLoadingServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 01.12.2025.
//

import UIKit

protocol ImageLoadingServiceProtocol {
    func loadImage(from url: URL) async throws -> UIImage?
}
