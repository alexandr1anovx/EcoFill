//
//  ResetEmailBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.04.2024.
//

import SwiftUI

struct ResetButton: View {
    let img: ImageResource
    let data: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(img)
                    .defaultImageSize
                Text("Reset \(data)")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
        .shadow(radius: 5)
    }
}
