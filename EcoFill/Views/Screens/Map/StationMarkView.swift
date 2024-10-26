//
//  StationMark.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI

struct StationMarkView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundStyle(.primaryBlue.gradient)
            .frame(width: 31, height: 31)
            .overlay {
                Image("gasStation")
                    .resizable()
                    .frame(width: 19, height: 19)
                    .foregroundStyle(.primaryOrange)
                    .padding(.leading, 1.6)       
            }
            .shadow(radius: 4)
    }
}
