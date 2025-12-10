//
//  FeatureAssemblies.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject

enum FeatureAssemblies {

    static var all: [Assembly] {
        return [
            LoaderAssembly(),
            AlertAssembly(),
            OnboardingAssembly(),
            AuthAssembly(),
            PhoneAuthAssembly(),
            PhoneVerifyAssembly(),
            UserRegAssembly(),
            MainAssembly(),
            HomeAssembly(),
            MapAssembly(),
			NewGameOrTourneyAssembly(),
            MyGamesAssembly(),
            ProfileAssembly(),
            NotificationsAssembly(),
            PaywallAssembly(),
            CreationSuccessAssembly(),
            PersonalDataAssembly(),
			EditProfilePhotoAssembly(),
			SupportAssembly(),
			FAQAssembly(),
            AboutAssembly(),
			UserCardAssembly()
        ]
    }
}
