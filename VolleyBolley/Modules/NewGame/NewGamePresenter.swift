//
//  Untitled.swift
//  VolleyBolley
//
//  Created by Олег Кор on 25.07.2025.
//

import UIKit

final class NewGamePresenter: NewGamePresenterProtocol {

    weak var view: NewGameViewProtocol?
    var interactor: NewGameInteractorProtocol
    var router: NewGameRouterProtocol

    init(view: NewGameViewProtocol,
         interactor: NewGameInteractorProtocol,
         router: NewGameRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        view?.setGetStartedButton(enabled: false)
        view?.showPlaceholder(true)
        view?.updateDateSelection(todaySelected: true)
    }

    func didChangeMessage(_ text: String) {
        interactor.updateMessage(text)
        view?.showPlaceholder(text.isEmpty)
        view?.updateMessageCount(interactor.getMessageCount())
        view?.setGetStartedButton(enabled: interactor.validateMessage(text))
    }

    func didToggleLevel(_ title: String) {
        interactor.toggleLevel(title)
        view?.updateSelectedLevels(interactor.getSelectedLevels())
    }

    func didToggleGender(_ title: String) {
        interactor.setGender(title)
        view?.updateSelectedGender(interactor.getSelectedGender())
    }

    func didConfirmDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: date)
        interactor.setDate(dateString)
        view?.updateSelectedDate(dateString)
    }

    func didConfirmPlace(_ place: String) {
        interactor.setPlace(place)
        view?.updateSelectedPlace(place)
    }

    func didTapGetStarted() {
       // TODO: Добавить переход на следующий экран
    }

    func didTapBack() {
        router.dismiss()
    }

    func didSelectDateButton(_ title: String) {
        if title == "Today" {
            view?.updateDateSelection(todaySelected: true)
            let today = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            let dateString = formatter.string(from: today)
            interactor.setDate(dateString)
            view?.updateSelectedDate(dateString)
        } else if title == "Pick date" {
            view?.updateDateSelection(todaySelected: false)
        }
    }
}
