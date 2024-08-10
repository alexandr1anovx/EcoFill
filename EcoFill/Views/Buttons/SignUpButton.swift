//
//  SignUpBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct SignUpButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.userSignUp)
                    .defaultImageSize
                Text("Sign Up")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(CustomButtonModifier(pouring: .orange))
        .shadow(radius: 5)
    }
}
