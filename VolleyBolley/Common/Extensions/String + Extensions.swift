//
//  String + Extensions.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 14.09.2025.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        guard let first = self.first else { return self }
        let capitalizedFirst = String(first).uppercased()
        let remaining = self.dropFirst().lowercased()
        return capitalizedFirst + remaining
    }
}
