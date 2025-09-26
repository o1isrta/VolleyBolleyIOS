//
//  NavBarNotificationModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 19.09.2025.
//

import Foundation

struct NavBarNotification {

	let isArrived: Bool

	init(isArrived: Bool) {
		self.isArrived = isArrived
	}

	init?(userInfo: [AnyHashable: Any]) {
		guard let isArrived = userInfo[NotificationConstants.NavBar.isArrivedKey] as? Bool else {
			return nil
		}
		self.isArrived = isArrived
	}

	var userInfo: [AnyHashable: Any] {
		return [
			NotificationConstants.NavBar.isArrivedKey: isArrived
		]
	}
}
