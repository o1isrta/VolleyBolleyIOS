//
//  NewGameInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Foundation

protocol NewGameInteractorProtocol: AnyObject {
	func validateMessage(_ text: String) -> Bool
	func updateMessage(_ text: String)
	func getMessageCount() -> Int

	func toggleLevel(_ title: String)
	func getSelectedLevels() -> [String]

	func setGender(_ title: String)
	func getSelectedGender() -> String?

	func setDate(_ date: String)
	func getSelectedDate() -> String?

	func setPlace(_ place: String)
	func getSelectedPlace() -> String?

	func buildGameData() -> NewGameData
}

protocol NewGameInteractorOutputProtocol: AnyObject {
	func gameSaved()
}

final class NewGameInteractor: NewGameInteractorProtocol {

    weak var output: NewGameInteractorOutputProtocol?

    private var message: String = ""
    private var selectedLevels: [String] = []
    private var selectedGender: String?
    private var selectedDate: String?
    private var selectedPlace: String?

    func validateMessage(_ text: String) -> Bool {
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func updateMessage(_ text: String) {
        message = text
    }

    func getMessageCount() -> Int {
        message.count
    }

    func toggleLevel(_ title: String) {
        if let index = selectedLevels.firstIndex(of: title) {
            selectedLevels.remove(at: index)
        } else {
            selectedLevels.append(title)
        }
    }

    func getSelectedLevels() -> [String] {
        selectedLevels
    }

    func setGender(_ title: String) {
        selectedGender = title
    }

    func getSelectedGender() -> String? {
        selectedGender
    }

    func setDate(_ date: String) {
        selectedDate = date
    }
    
    func getSelectedDate() -> String? {
        selectedDate
    }

    func setPlace(_ place: String) {
        selectedPlace = place
    }

    func getSelectedPlace() -> String? {
        selectedPlace
    }

    func buildGameData() -> NewGameData {
        return NewGameData(
            message: message,
            levels: selectedLevels,
            gender: selectedGender,
            date: selectedDate,
            place: selectedPlace
        )
    }
}
