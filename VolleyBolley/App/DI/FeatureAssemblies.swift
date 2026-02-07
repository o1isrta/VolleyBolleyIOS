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
            OnboardingAssembly(),
            AuthAssembly(),
            PhoneAuthAssembly(),
            PhoneVerifyAssembly(),
			RegistrationAssembly(),
            MainAssembly(),
            HomeAssembly(),
            MapAssembly(),
			NewGameOrTourneyAssembly(),
            MyGamesAssembly(),
            ProfileAssembly(),
            NotificationsAssembly(),
            PaywallAssembly(),
			CreateTourneyAssembly(),
            CreationSuccessAssembly(),
            PersonalDataAssembly(),
			EditProfilePhotoAssembly(),
			SupportAssembly(),
			FAQAssembly(),
            AboutAssembly(),
			UserCardAssembly(),
			PlayersListAssembly(),
			InvitePlayersAssembly()
        ]
    }
}
