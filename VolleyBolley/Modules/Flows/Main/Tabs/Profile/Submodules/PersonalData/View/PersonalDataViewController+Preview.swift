//
//  PersonalDataViewController+Preview.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 02.10.2025.
//

#if DEBUG
import SwiftUI

struct PersonalDataViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: PersonalDataPresenterProtocol {
        let countries: [String] = ["Cyprus", "Thailand"]
        let cities: [String] = ["Koh Phangan", "Koh Samui"]
        weak var view: PersonalDataViewProtocol?
        func viewDidLoad() {}
        func backButtonTapped() {}
        func updateButtonTapped() {}
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let presenter = StubPresenter()
        return PersonalDataViewController(presenter: presenter)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct PersonalDataViewController_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
