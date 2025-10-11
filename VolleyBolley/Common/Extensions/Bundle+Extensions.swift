//
//  Bundle+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 11.10.2025.
//

import Foundation

extension Bundle {
	
	var appVersion: String {
		return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "N/A"
	}

	var appBuild: String {
		return object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "N/A"
	}
}
