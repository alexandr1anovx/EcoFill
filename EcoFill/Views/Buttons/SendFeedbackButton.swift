//
//  SendFeedbackBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct SendFeedbackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.checkmark)
                    .defaultImageSize
                Text("Send feedback")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
        .shadow(radius: 5)
    }
}
