//
//  SignUpBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct SignUpBtn: View {
    
    // MARK: - Public Properties
    var action: () -> Void
    
    // MARK: - body
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.userSignUp)
                    .defaultSize()
                Text("Sign Up")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(CustomButtonModifier(pouring: .orange))
        .shadow(radius: 5)
    }
}
