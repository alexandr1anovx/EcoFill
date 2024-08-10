//
//  DeleteUserBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct DeleteAccountButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.userDelete)
                    .defaultImageSize
                Text("Delete account")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
        .shadow(radius: 5)
    }
}
