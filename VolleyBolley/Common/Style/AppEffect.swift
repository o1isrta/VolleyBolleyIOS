//
//  AppEffect.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

/// Эффекты такие как эффект стекла, блюры и прочие
enum AppEffect {
    enum Background {
        static let alert = semiTransparentGray
		static let popup = transparentGray
    }

	enum Table {
		static let cellWhiteSelected = tableCellWhiteSelected
	}
}

private extension AppEffect {
    static let semiTransparentGray = AppColor.Background.alert.withAlphaComponent(0.3)
    static let transparentGray = AppColor.Background.alert.withAlphaComponent(0.7)
	static let tableCellWhiteSelected = AppColor.Table.cellWhiteSelected.withAlphaComponent(0.3)
}
