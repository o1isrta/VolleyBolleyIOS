//
//  AppEffect.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

/// Эффекты такие как эффект стекла, блюры и прочие
enum AppEffect {
    enum BackgroundAlert {
        static let alert = semiTransparentGray
    }

	enum Table {
		static let cellWhiteSelected = tableCellWhiteSelected
	}
}

private extension AppEffect {
    static let semiTransparentGray = AppColor.Background.alert.withAlphaComponent(0.3)
	static let tableCellWhiteSelected = AppColor.Table.cellWhiteSelected.withAlphaComponent(0.3)
}
