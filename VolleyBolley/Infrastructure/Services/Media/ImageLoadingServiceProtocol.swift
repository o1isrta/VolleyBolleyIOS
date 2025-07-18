//
//  ImageLoadingServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import UIKit

protocol ImageLoadingServiceProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}
