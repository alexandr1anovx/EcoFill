//
//  GetDirectionsBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct ShowRouteButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.route)
                    .defaultImageSize
                Text("Route")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .cmBlue)
        .shadow(radius: 5)
    }
}
