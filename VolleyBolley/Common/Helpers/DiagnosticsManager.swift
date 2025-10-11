//
//  DiagnosticsManager.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

import UIKit

struct DiagnosticsManager {

	// MARK: - Public Properties

	static func generateEmailBody(with userMessage: String = "") -> String {
		let deviceInfoItems = collectDeviceInfo()
		var emailBody = """
		<html>
		<head>
			<style>
				body { font-family: Arial, sans-serif; margin: 20px; }
				.header { color: #333; border-bottom: 2px solid #007AFF; padding-bottom: 10px; }
				.section { margin: 20px 0; }
				.section-title { color: #007AFF; font-weight: bold; margin-bottom: 10px; }
				.info-table { width: 100%; border-collapse: collapse; }
				.info-table td { padding: 8px 12px; border-bottom: 1px solid #eee; }
				.info-table tr:nth-child(even) { background-color: #f9f9f9; }
				.user-message { background-color: #f0f8ff; padding: 15px; border-radius: 5px; border-left: 4px solid #007AFF; }
			</style>
		</head>
		<body>
			<div class="header">
				<h2>📱 Diagnostic report</h2>
			</div>
		"""
		// User message
		if !userMessage.isEmpty {
			emailBody += """
			<div class="section">
				<div class="section-title">✍️ User message:</div>
				<div class="user-message">\(userMessage)</div>
			</div>
			"""
		}
		// Device Information
		emailBody += """
			<div class="section">
				<div class="section-title">📊 Device Information:</div>
				<table class="info-table">
		"""

		for item in deviceInfoItems {
			emailBody += """
					<tr>
						<td><strong>\(item.displayName):</strong></td>
						<td>\(item.value)</td>
					</tr>
			"""
		}

		emailBody += """
				</table>
			</div>
			</body>
			</html>
		"""

		return emailBody
	}

	static func generatePlainTextBody(with userMessage: String = "") -> String {
		let deviceInfoItems = collectDeviceInfo()
		var textBody = userMessage
		textBody += "\n\n\n\n---\n"
		textBody += "=== \(String(localized: "emailToSupport.report.start")) ===\n\n"
		textBody += "\(String(localized: "emailToSupport.report.warning"))\n\n"
		textBody += "\(String(localized: "emailToSupport.deviceInfo")):\n"
		textBody += "────────────────────\n"

		for item in deviceInfoItems {
			textBody += "\(item.displayName): \(item.value)\n"
		}

		textBody += "\n=== \(String(localized: "emailToSupport.report.end")) ==="

		return textBody
	}

	// MARK: - Private Properties

	private struct DeviceInfoItem {
		let key: String
		let displayName: String
		let value: String
	}

	private enum DeviceInfoKey: String, CaseIterable {
		case deviceName = "device_name"
		case deviceModel = "device_model"
		case appVersion = "app_version"
		case buildNumber = "build_number"
		case iosVersion = "ios_version"
		case systemName = "system_name"
		case locale = "locale"
		case timeZone = "time_zone"
		case timestamp = "timestamp"

		var displayName: String {
			switch self {
			case .appVersion: return String(localized: "emailToSupport.appVersion")
			case .buildNumber: return String(localized: "emailToSupport.buildNumber")
			case .deviceName: return String(localized: "emailToSupport.deviceName")
			case .deviceModel: return String(localized: "emailToSupport.deviceModel")
			case .iosVersion: return String(localized: "emailToSupport.iosVersion")
			case .systemName: return String(localized: "emailToSupport.systemName")
			case .locale: return String(localized: "emailToSupport.locale")
			case .timeZone: return String(localized: "emailToSupport.timeZone")
			case .timestamp: return String(localized: "emailToSupport.timestamp")
			}
		}

		func getValue() -> String {
			switch self {
			case .appVersion:
				return Bundle.main.appVersion
			case .buildNumber:
				return Bundle.main.appBuild
			case .iosVersion:
				return UIDevice.current.systemVersion
			case .deviceModel:
				return UIDevice.current.model
			case .deviceName:
				return UIDevice.current.name
			case .systemName:
				return UIDevice.current.systemName
			case .locale:
				return Locale.current.identifier
			case .timeZone:
				return TimeZone.current.identifier
			case .timestamp:
				return Date().ISO8601Format()
			}
		}
	}

	// MARK: - Private Methods

	private static func collectDeviceInfo() -> [DeviceInfoItem] {
		return DeviceInfoKey.allCases.map { key in
			DeviceInfoItem(
				key: key.rawValue,
				displayName: key.displayName,
				value: key.getValue()
			)
		}
	}
}
