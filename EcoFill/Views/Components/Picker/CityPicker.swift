//
//  CityPicker.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 03.09.2024.
//

import SwiftUI

struct CityPicker: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        HStack {
            Image(.mark)
                .defaultImageSize
            Picker("", selection: $userVM.selectedCity) {
                ForEach(City.allCases) { city in
                    Text(city.rawValue)
                }
            }
            .tint(.cmReversed)
        }
    }
}
