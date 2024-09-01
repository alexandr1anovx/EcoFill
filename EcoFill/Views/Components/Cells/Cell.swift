//
//  Cell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.09.2024.
//

import SwiftUI

enum FuelType: String {
    case euroA95 = "A95 Euro"
    case euroDP = "DP Euro"
    case gas = "Gas"
}

struct Cell: View {
    let type: FuelType
    let price: Double
    
    var body: some View {
        HStack {
            Text(type.rawValue)
                .bold()
            Text("\(price)")
        }
    }
}

struct ScrollableF: View {
    
    let station: Station
    
    var body: some View {
        ScrollView(.horizontal) {
            Cell(type: .euroA95, price: station.euroA95)
            Cell(type: .euroDP, price: station.euroDP)
            Cell(type: .gas, price: station.gas)
        }
    }
}
