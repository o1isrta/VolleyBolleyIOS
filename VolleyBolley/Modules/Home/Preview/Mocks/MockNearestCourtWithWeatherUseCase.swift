//
//  MockNearestCourtWithWeatherUseCase.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.09.2025.
//

import Foundation

final class MockNearestCourtWithWeatherUseCase: NearestCourtWithWeatherUseCaseProtocol {

    // MARK: - Public Methods

    func getNearestCourtWithWeather(for country: String) async throws -> NearestCourtWithWeather {

        let nearestCourt = Court(
            id: 1,
            name: "Karon Beach Club",
            description: "description",
            address: "Patak Rd, Mueang Phuket",
            location: GeoPoint(lat: 7.84590, lon: 98.29348),
            priceDescription: "200฿/60min\n300฿/120min",
            photoURL: URL(
                string: "https://github.com/xcode73/myapp-mocks/blob/main/VolleyBolley/Images/Venues/" +
                        "beach_volleyball/img1.png?raw=true"
            ),
            tags: [
                "10 courts",
                "Outdoor",
                "Lights"
            ],
            contacts: [Contact(type: "PHONE", value: "+66 872 567 608")]
        )
        let weather = AppWeather(temperature: 26.0, condition: .partlyCloudy)

        return NearestCourtWithWeather(court: nearestCourt, weather: weather)
    }
}
