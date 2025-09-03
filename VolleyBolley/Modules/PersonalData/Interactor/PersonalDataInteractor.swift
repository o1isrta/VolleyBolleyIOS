//
//  PersonalDataInteractor.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

protocol PersonalDataInteractorProtocol: AnyObject {
    func loadData()
}

final class PersonalDataInteractor: PersonalDataInteractorProtocol {
    
    func loadData() {
        // Заглушка: здесь будет загрузка персональных данных
        print("Personal data loaded")
    }
}
