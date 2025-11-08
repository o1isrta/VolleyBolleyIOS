//
//  CGFloat+Scaling.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 08.11.2025.
//

import UIKit

private let baseScreenHeight: CGFloat = 812.0
private let baseScreenWidth: CGFloat = 375.0

private var screenHeightRatio: CGFloat { UIScreen.main.bounds.height / baseScreenHeight }
private var screenWidthRatio: CGFloat { UIScreen.main.bounds.width / baseScreenWidth }

extension CGFloat {
    var scaledByScreenHeight: CGFloat { self * screenHeightRatio }
    var scaledByScreenWidth: CGFloat { self * screenWidthRatio }
}

extension BinaryInteger {
    var scaledByScreenHeight: CGFloat { CGFloat(self) * screenHeightRatio }
    var scaledByScreenWidth: CGFloat { CGFloat(self) * screenWidthRatio }
}

extension BinaryFloatingPoint {
    var scaledByScreenHeight: CGFloat { CGFloat(self) * screenHeightRatio }
    var scaledByScreenWidth: CGFloat { CGFloat(self) * screenWidthRatio }
}
