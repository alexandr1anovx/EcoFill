//
//  Station.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 06.02.2024.
//

import Foundation
import MapKit

struct Station: Decodable, Identifiable, Hashable {
    let id: String
    let city: String
    let euroA95: Double
    let euroDP: Double
    let gas: Double
    let latitude: Double
    let longitude: Double
    let name: String
    let postalCode: String
    let schedule: String
    let street: String
    
    var address: String {
        "\(city), \(street), \(postalCode)"
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}

extension Station {
    static var testStation = Station(
        id: "test",
        city: "Kyiv",
        euroA95: 53.99,
        euroDP: 54.99,
        gas: 24.99,
        latitude: 50.447306,
        longitude: 30.494783,
        name: "EcoFill",
        postalCode: "02000",
        schedule: "08:00-23.00",
        street: "Olesia Honchara St, 79-75"
    )
}

