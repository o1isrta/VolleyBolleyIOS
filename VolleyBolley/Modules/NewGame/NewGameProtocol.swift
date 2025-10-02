//
//  NewGameProtocol.swift
//  VolleyBolley
//
//  Created by Олег Кор on 25.07.2025.
//

import UIKit

protocol NewGameViewProtocol: AnyObject {
    func setGetStartedButton(enabled: Bool)
    func updateMessageCount(_ count: Int)
    func updateSelectedLevels(_ titles: [String])
    func updateSelectedGender(_ title: String?)
    func showPlaceholder(_ show: Bool)
    func updateDateSelection(todaySelected: Bool)
    func updateSelectedPlace(_ place: String?)
    func updateSelectedDate(_ date: String?)
}

protocol NewGamePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didChangeMessage(_ text: String)
    func didToggleLevel(_ title: String)
    func didToggleGender(_ title: String)
    func didSelectDate()
    func didSelectPlace()
    func didConfirmDate(_ date: Date)
    func didConfirmPlace(_ place: String)
    func didTapGetStarted()
    func didTapBack()
    func didSelectDateButton(_ title: String)
}

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

protocol NewGameRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func routeToMain(with data: NewGameData?)
    func showDatePicker(from: UIViewController?)
    func showPlacePicker(from: UIViewController?)
    func dismiss()
}
